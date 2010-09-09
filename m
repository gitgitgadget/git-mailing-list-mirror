From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/4] xdiff-interface.c: always trim trailing space from
 xfuncname matches
Date: Thu, 09 Sep 2010 14:33:15 -0500
Message-ID: <GLdpD2WwjdTYfjYpj9FXho_K_YzeaiL1jdGACbdsXplUz5EPC0X3vA@cipher.nrlssc.navy.mil>
References: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil> <rRj7JpFIk_D_n7-wGkkucCda_kClmekHTPEHOGwmU5nYdmNhqqgzF59v609YFx69vv526WtEpyU@cipher.nrlssc.navy.mil> <20100909192108.GC32508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:33:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmsB-0004Lx-Af
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab0IITdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:33:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43302 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab0IITdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:33:19 -0400
Received: by mail.nrlssc.navy.mil id o89JXFeP004865; Thu, 9 Sep 2010 14:33:15 -0500
In-Reply-To: <20100909192108.GC32508@sigill.intra.peff.net>
X-OriginalArrivalTime: 09 Sep 2010 19:33:15.0457 (UTC) FILETIME=[D9138B10:01CB5055]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155891>

On 09/09/2010 02:21 PM, Jeff King wrote:
> On Thu, Sep 09, 2010 at 02:02:46PM -0500, Brandon Casey wrote:
> 
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Generally, trailing space is removed from the string matched by the
>> xfuncname patterns.  The exception is when the matched string exceeds the
>> length of the fixed-size buffer that it will be copied in to.  But, a
>> string that exceeds the buffer can still contain trailing space in the
>> portion of the string that will be copied into the buffer.  So, simplify
>> this code slightly, and just perform the trailing space removal always.
> 
> Hrm. So we are cutting off trailing space that might have been
> non-trailing space in their original string? It is hard to argue that is
> much worse than truncating the original string in the first place. But I
> really wonder whether we should be silently truncating anything, and not
> just dying or somehow handling this better?
> 
> If I understand what is going on (and I'm not sure that I do), are we
> silently producing bogus word-diffs in the face of really long lines?

I don't think this function is used to do the word-diffs.  Unless I'm
missing something, ff_regexp is only used to do the funcname matching to
produce the hunk header string.  An 80-byte buffer is used to hold
that string.  So, the trimming is performed on what is effectively a
comment.

-Brandon
