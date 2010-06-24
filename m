From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 14:23:09 +0200
Message-ID: <71BD27DC-9CA7-40E8-8253-ABF61083E53C@gmail.com>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <20100624111757.GB3453@pvv.org> <4C2344C0.2010402@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 14:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORlSi-00026T-99
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 14:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab0FXMXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 08:23:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63622 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab0FXMXN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 08:23:13 -0400
Received: by wyi11 with SMTP id 11so1611011wyi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 05:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=zczWWum24c21Z7jwzGoY9tAZeEz5lBVVECcDkeM6dOY=;
        b=i1EkVNdm6WtG9hZuk6cuKRDOS22Qhj/JG8PpkIuo3eqebUxCj4SRFO3VpI5FP2oDYE
         /v+QkXBXoSx91emsgMCORc+4MthnUV/HanK3FOHMAUs9pLektF9Ku6Kgp8JtDPIFuEbe
         U+HYk6HBJM9xUvneJcfTuFOMA6GCCG1mKO0dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=rmrHjMY77PwDAQCC3XWPILEGR86/vfT16k3sZ1K5MH/R7VEA99sFhaf3bDTJuH62Z9
         HQVLrdxi2Wur5K5SOdM5jZ8kFukWPzlAyBTFPWznOn8RTdTtpmTx5VSsiipgkKEDfSga
         UaLcbgbPJplrULvug/Zer+jStVx7YvfQmJIiI=
Received: by 10.216.154.69 with SMTP id g47mr7201985wek.82.1277382191911;
        Thu, 24 Jun 2010 05:23:11 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id h1sm812590wee.31.2010.06.24.05.23.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 05:23:11 -0700 (PDT)
In-Reply-To: <4C2344C0.2010402@viscovery.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149586>

On 24. juni 2010, at 13.42, Johannes Sixt wrote:

> Am 6/24/2010 13:17, schrieb Finn Arne Gangstad:
>> Assume you start out with a repo that has a lot of text files with
>> CRLF checked in (A).
>> 
>>  C----
>> /     \
>> A---B---D
>> 
>> B: Add "* text=auto" to .gitattributes and normalize all files to LF
>> only in repo
>> 
>> D: try to merge C
>> 
>> Without this patch you will get a ridiculous number of lf/crlf
>> conflicts when trying to merge C into D, since the repository contents
>> for C are "wrong" wrt the new .gitattributes file.
> 
> What should happen when you have C checked out (i.e., you do not yet have
> the updated .gitattributes in your worktree nor index) and merge B?
> Currently, you get the identical conflicts, but I suspect that the patch
> does not help in this situation. IOW, it breaks the merge symmetry.

I confess that I didn't expect this to work either, but it does: the merge completes without conflict.  This is even covered in the included test script ("Check merging addition of text=auto").

I've cleaned the patch up a bit and added automatic delete/normalize conflict resolution.  Will submit a new version soon.
-- 
Eyvind Bernhardsen
