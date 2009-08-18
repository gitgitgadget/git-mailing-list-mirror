From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: Null deref in recursive merge in df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Tue, 18 Aug 2009 23:35:17 +0200
Message-ID: <4c8ef70908181435o1f9c6d0dncd84eb57b070b105@mail.gmail.com>
References: <D5F958F92101F74D8A5683C2FE14F4200F23102F@post.corp.w3data.com>
	 <C695A6A4.61CD9%jbenjore@whitepages.com>
	 <7vtz0uk5z3.fsf@alter.siamese.dyndns.org>
	 <7viqhaipg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin <johannes.schindelin@gmx.de> Alex Riesen" 
	<raa.lkml@gmail.com>, Git <git@vger.kernel.org>,
	Josh ben Jore <jbenjore@whitepages.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:35:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWL6-0000il-DY
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbZHRVfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 17:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZHRVfS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:35:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:47162 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbZHRVfR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 17:35:17 -0400
Received: by fg-out-1718.google.com with SMTP id e21so942471fga.17
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YeP55OX++bDRKe5FQCC0hCczGt26Dtn9eKpxQohQuXg=;
        b=AfwBhs1KUVVyi4i1CfW8M8XHyoO5r29Ehw8pwclzBishYA3t0tjIxdSHmMr8zEMyE0
         ++PG0YztIs6VyJ9fMGUKqkkdNjMcX2zNtz6TmmiRx0md6BRMXBwiKsPOXlXP8L8RkYsm
         7BCQ5OhFZWZ12zDs7r0GlUaCJlplQDCeZPTYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oUBuQIF+DhHmldUl1no8Ev1ggOTVjb2GWs3gbQ8XGy1U635aACZOpdoCCp43iNB0oo
         svxHdQEPXNTZPdtE5d0Yi7yQkwQOjuXfjcqTonFPBtVYuJIXSFnXCFNzAliujPwmhSpt
         LVdDWjAx3uhN64ZOrb5B1uFp53h7vg2mr2PeY=
Received: by 10.239.179.99 with SMTP id c35mr496121hbg.161.1250631317746; Tue, 
	18 Aug 2009 14:35:17 -0700 (PDT)
In-Reply-To: <7viqhaipg0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126460>

On Thu, Jul 30, 2009 at 9:45 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The codepath saw that one branch renamed dev-ubuntu/ stuff to dev/ a=
t that
>> "unmerged" path, while the other branch added something else to the =
same
>> path, and decided to add that at an alternative path, and the intent=
 of
>> that is so that it can safely resolve the "renamed" side to its fina=
l
>> destination. =A0The added update_file() call is about finishing that
>> conflict resolution the code forgets to do.
>
> By the way, (I am CC'ing Fredrik, the author of the merge-recursive.p=
y,
> the original implementation, even though I haven't seen him around he=
re
> for a long time. Two "thieves" are also CC'ed), I think the way recur=
sive
> strategy tries to handle rename/add and rename/rename conflicts by co=
ming
> up with a temporary pathname is fundamentally wrong.

It was a long time ago I looked at the merge stuff (or any git code in
fact) so I
may have forgotten some things. However, as far as I can see your analy=
sis is
correct and the temporary pathname stuff can be avoided when the confli=
cts
only involve files (and no directories). As you wrote, for D/F
conflicts one need
the temporary pathnames in order to build a tree which is used in the v=
irtual
ancestor.

[Nice analysis of when temporary pathnames are needed and when they are=
 not
needed snipped.]

- Fredrik

PS. I am sorry for the late reply.
