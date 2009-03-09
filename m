From: John Tapsell <johnflux@gmail.com>
Subject: Re: Help designing work flow
Date: Mon, 9 Mar 2009 11:44:47 +0000
Message-ID: <43d8ce650903090444n352f310fs9cd4b8b0184be010@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F07D30@EXCHANGE.trad.tradestation.com>
	 <49B4F5A9.5060304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 09 12:46:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgdw2-0003GI-Fw
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 12:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbZCILou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 07:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbZCILou
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 07:44:50 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:29646 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbZCILot convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 07:44:49 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1917345wfa.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=58gntPOXnHWaYRkvVO0nH9eN+aF9IkX+O0kW/KaXCsY=;
        b=gaqkZmyB4WlGBqQEaJflI/PQiQvrbFE/NILk8vlXBjix2YWDrG3vCEt/RQQZHANzaV
         kHzh5u/kwVySJnLB0MTmTY5mXwufshw09IEQDc9UoJagQpLHoITU3li8u4NGMiaph45m
         Lwa7atQOYMTTSEDP0FzPjH3Ecl5DN3POq+HRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RHFDYIm7LjT9PqoHFpTJN1ZkteBU2XHZXiHGL+lLGzHSzfdnyCBcUuaDDocLxLGOuB
         VmRu7KKorVQPTdX60lXebkvKKAZu/3WPzQN9hNdyNZ2oDoxbNAC2iaAyDleao6+67m77
         YeIsMQLtty2zHV38bOT4osPUn5wHCR9IPhKHM=
Received: by 10.142.158.3 with SMTP id g3mr2505638wfe.265.1236599087319; Mon, 
	09 Mar 2009 04:44:47 -0700 (PDT)
In-Reply-To: <49B4F5A9.5060304@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112690>

2009/3/9 Andreas Ericsson <ae@op5.se>:
> John Dlugosz wrote:
>>
>> I know we (my group) should use "topic" branches and apply them back=
 to
>> the dev branch when done. =C2=A0There is concern that the commit his=
tory gets
>> too full of detailed stuff, especially with several developers, that=
 you
>> can't tell what "really changed". =C2=A0So, our dev branch should ap=
pear to
>> contain only commit nodes representing completed assignments; not ev=
ery
>> day's checkpoint and trying to keep one's own stuff on top to avoid
>> merging later.
>>
>> I guess that's how it is on these Open Source projects where patches=
 are
>> submitted by email and applied by the maintainer. =C2=A0We don't see=
 the
>> details, just the final patch. =C2=A0But, my situation will be devel=
opers
>> gathered around an in-house master repo, and everyone should be able=
 to
>> push their own changes as assignments are completed.
>>
>> What is the best procedure to achieve that? =C2=A0Or what are some g=
ood
>> alternatives with trade-offs?
>>
>
> Use topic-branches and let someone merge them into master after havin=
g
> verified that they work properly.
>
> We usually commit simple bugfixes directly to master and then have
> developers rebase their changes onto master when they're ready to

The trouble with rebasing is that it then you end up with lots of
patches that haven't been tested.  You can end up with lots of
uncompiling commits.

Although merging is no better either.  Then you end up with one single
commit that tries to merge two trees, making it almost impossible to
track down bugs that resulted from the merge.

> integrate it. They push their development branches though, and furthe=
r
> changes to the topic are done on the topic-branches which can get
> merged to master (or stable) many times. Once a topic is merged, we
> always "git commit --amend" the merge commit to write a proper
> commit-message for it, adding a link to our bug- and feature-tracker
> so we get the at-a-glance information quickly and can dig up the
> entire discussion history around the bug/feature later. Each topic
> should be complete with documentation and test-cases before it's
> merged.
>
>
>> I see that if a topic branch is merged (disabling FF if applicable),=
 the
>> main line (leftmost parent) will be a history of completed topics. =C2=
=A0But,
>> we don't need to keep the detailed side-branches forever, and even i=
f
>> gitk and other visualization =C2=A0tools can be told to just show th=
e main
>> line, advanced use such as git log this..that will forever be packed
>> with the micro-details.
>>
>
> You can tell "git log" to only show one line of history too, but besi=
des
> that, micro-details are good. You definitely want to be able to searc=
h
> the micro-details when things go awry (and they will), so you see exa=
ctly
> why some particular algorithm changed later.
>
>> So, unless someone has more input along that line, I'm assuming that=
 we
>> want to apply the completed topic as a single-parent commit. =C2=A0T=
hat is
>> the natural result if preparing patches and then applying them, but =
is
>> there a simpler, direct way to do that in git?
>>
>
> You do not want to do that. We did it for a while, and it was hell wh=
en
> we found out that one of them broke down. The really, really *nice* t=
hing
> about git is called "git bisect". What makes it so awesomely nice is
> that, instead of looking at a 100k diff-file knowing that somewhere i=
n
> there a bug was introduced, you get (with good discipline using small
> commits), a 1-40 line patch with a clear and concise message of why
> those changes were thought necessary at that time. Applying a topic
> branch as a single patch would rob you of that functionality, and you
> will regret it. Trust me on this.
>
>> The detailed topic branches can be kept around for a while, for the
>> original author to extend if it needs to be returned to, and to exam=
ine
>> if the gestalt change in the single commit is too overwhelming to
>> understand, or to help figure out what might have broken. =C2=A0But =
after a
>> while they can be deleted and then gc will free up the disk space.
>>
>
> But if they do need to be returned to, you cannot merge them again if
> you've already applied the topic-patch (ugh), since you'd get conflic=
ts
> if any of the sections touched by the patch have been changed since.
>
> We use topic-branches quite a lot. When we're done with them we delet=
e
> the branch-pointers but I wouldn't, ever, dream of re-cooking them as
> mega-patches when applying them to master.
>
> --
> Andreas Ericsson =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 andreas.ericsson@op5.se
> OP5 AB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 www.op5.se
> Tel: +46 8-230225 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Fax: +46 8-230231
>
> Considering the successes of the wars on alcohol, poverty, drugs and
> terror, I think we should give some serious thought to declaring war
> on peace.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
