From: Samuel Bronson <naesten@gmail.com>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Fri, 18 Nov 2011 18:30:05 +0000 (UTC)
Message-ID: <loom.20111118T191851-152@post.gmane.org>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com> <20111118034142.GA25228@elie.hsd1.il.comcast.net> <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com> <buor516m3w7.fsf@dhlpc061.dev.necel.com> <CACsJy8BuCdT3rRjc5u6Ex5RRgSbL_0SFF0GW-dTGqet4sG2cwg@mail.gmail.com> <CACsJy8CKmjq01KoLRzOnnaf6RwFCQJfjxziqKTZW9HDyd8CagA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 20:50:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRURz-0002gh-3I
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 20:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab1KRTuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 14:50:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:59154 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864Ab1KRTuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 14:50:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RRURo-0002ah-CK
	for git@vger.kernel.org; Fri, 18 Nov 2011 20:50:04 +0100
Received: from 207-172-114-83.c3-0.upd-ubr1.trpr-upd.pa.cable.rcn.com ([207.172.114.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 20:50:04 +0100
Received: from naesten by 207-172-114-83.c3-0.upd-ubr1.trpr-upd.pa.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 20:50:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 207.172.114.83 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.36 Safari/535.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185676>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> 
> On Fri, Nov 18, 2011 at 6:34 PM, Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> 
wrote:
> > OK it's not gcc problem. I upgraded to 4.5.3 and still had the same
> > problem. I used ccache though. Without ccache, gcc produced correct
> > .o.d files.
> 
> "gcc -MF depfile -MMD -MP -c -o path/to/file.o" will produce "depfile"
> with target given by "-o". When ccache runs, it executes "gcc -MF
> depfile -MMD -MP -E" instead to get the final content for hashing.
> Notice that "-c -o" combination is replaced by "-E". The latter
> produces target without leading path.
> 
> Not sure if I should report this to ccache or gcc. In the meantime,
> may be we should recognize the situation and switch off
> COMPUTE_HEADER_DEPENDENCIES when ccache is used (maybe hard).

I'm pretty sure you should report this against ccache; GCC seems to be
behaving as documented. (I believe there is another flag that ccache
should be passing in to tell GCC what target to use in the depfile.)

Of course, it'd be wise to make sure that this problem still occurs in
the most recent version of ccache you can conveniently try it with before
reporting...
