From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according to git-log rules.
Date: Wed, 22 Oct 2008 13:32:56 +0400
Message-ID: <bb6f213e0810220232p2e7fe3daoa32f46fbe5bef2ac@mail.gmail.com>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com>
	 <20081022082016.GA18473@sigill.intra.peff.net>
	 <bb6f213e0810220135hd520f78odb83414c248a15e4@mail.gmail.com>
	 <20081022085036.GA1454@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 11:34:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksa6X-0001VU-4w
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 11:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbYJVJc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 05:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYJVJc6
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 05:32:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:25752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbYJVJc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 05:32:58 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1299798ugf.37
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vdK8y1H+iIe4aEElttar9Co0RQLR92MgT3pDKtu3BA8=;
        b=dCrp2XoQVXfO3YLwEhWlwyfKPGXjge26xvRpqy590Kjf02pENet0eey/p5N6B2qGkS
         uHbvGsVL+lztBf/kKGFpcfsC+S4vuiPwFnXc/IP4JZhTDZj0p5IkeouDMzkiHV7SZwnM
         bmu9SsSoJhg0y67k40TbO+DgF5fJmaXi4ares=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UqBGAauOBzxLTz9hi4PLoDeLYAERqvMb9LwYw9p8R9UFLACYsyQd5tQ94DZ5VVaXiI
         lF/YDzoHsSO2rcvVPvcry6HnFJ+rL0BsUYR/k9/Co2au4Bwl0ra14bGh+wDzFcsal5oV
         LNEgagUTw2Ex6ksAsrPhsw86tLqMaNqwyUhro=
Received: by 10.102.234.18 with SMTP id g18mr5023726muh.105.1224667976251;
        Wed, 22 Oct 2008 02:32:56 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Wed, 22 Oct 2008 02:32:56 -0700 (PDT)
In-Reply-To: <20081022085036.GA1454@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98853>

On Wed, Oct 22, 2008 at 12:50 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 22, 2008 at 12:35:17PM +0400, Alexander Gavrilov wrote:
>
>> > instead. Of course, I can't get your test to pass even with that change,
>> > but I think that is just a broken iconv on Solaris.
>>
>> Hm, which of the conversions fail? You can try manually converting the
>> txt files with the iconv command to figure it out.
>
> Test 2 fails for CP1251 and SJIS.  Manually converting with iconv seems
> to work ok (at least, doing "iconv -f CP1251 -t UTF-8 cp1251.txt"
> produces the same output as "cat utf8.txt".
>
> The output from "t8005-blame-i18n.sh -v -i" is attached (as
> application/octet-stream to protect it from email munging) if that is
> helpful to you. I can't make heads or tails of it.

>From the output it seems that what fails is "-f cp1251 -t sjis" and
"-f utf-8 -t sjis" (remember that blame --incremental produces its
output in reverse order compared to the order of commits). Unless
blame for some reason actually tries to convert to an entirely
different encoding. If tests 4 and 5 pass, you can try adding
--encoding=shift-jis to test 2 to check it.

Alexander
