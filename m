From: Shawn Pearce <sop@google.com>
Subject: Re: Excluding some refspecs from git push?
Date: Sun, 24 Jul 2011 12:45:20 -0700
Message-ID: <CAH+XAArFNE2NdGf=iZtrCzHCazY8d+LN9D6z21dfFX7h8dTNMQ@mail.gmail.com>
References: <20110724004650.408741c5@x34f> <CAH+XAApbbMSPW9XJPjYnmqNiECoWBz5du6CeD_hfAww9o_LcXA@mail.gmail.com>
 <20110724193240.GA16283@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Shawn Pearce <sop@google.com>,
	Paul Sokolovsky <paul.sokolovsky@linaro.org>,
	git@vger.kernel.org, repo-discuss <repo-discuss@googlegroups.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 21:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql4cV-0001tr-S8
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 21:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab1GXTpn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 15:45:43 -0400
Received: from smtp-out.google.com ([216.239.44.51]:37684 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab1GXTpl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 15:45:41 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p6OJjf3c007746
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 12:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1311536741; bh=F2Knggp8h4EwHW9DkIWXy1PhCxU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type:Content-Transfer-Encoding;
	b=rMeHJBqaxXhCcNN/6khYjNhWFqo9kU1mWe/lO7n/7gcEkyy/fqMwZ/RYCKNXGykEz
	 IASnWNlOPm/K14nMorncg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:from:date:
	message-id:subject:to:content-type:
	content-transfer-encoding:x-system-of-record;
	b=JR8jdslg1QzFpBBD44RVRV0zKzTUdjImbS8CfBfcrQDz0JFJMwp7tKYs9hVBGHdts
	Z8MgWWZyihn+MgO97yifw==
Received: from yxp4 (yxp4.prod.google.com [10.190.4.196])
	by wpaz5.hot.corp.google.com with ESMTP id p6OJjeT8008733
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 12:45:40 -0700
Received: by yxp4 with SMTP id 4so1854046yxp.3
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=oaRpWp/5hkCb/8QEKWmSaZhuxj2ypBtKlsgtig4ztp4=;
        b=j8UYuRkMeuoqZ1Rc2NP1R6MlmdTdaIC6JCl32hUZGAQTuZiuxOqpDjGB5UcuSaxkED
         BgUhdyRY/kpehtQ+fuFg==
Received: by 10.90.17.27 with SMTP id 27mr3588073agq.188.1311536740130; Sun,
 24 Jul 2011 12:45:40 -0700 (PDT)
Received: by 10.91.203.15 with HTTP; Sun, 24 Jul 2011 12:45:20 -0700 (PDT)
In-Reply-To: <20110724193240.GA16283@jpl.local>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177776>

On Sun, Jul 24, 2011 at 12:32, Magnus B=E4ck <magnus.back@sonyericsson.=
com> wrote:
>>
>> Unfortunately no. But you should be able to just mirror the namespac=
es
>> that matter:
>>
>> =A0 refs/heads/*
>> =A0 refs/tags/*
>
> Any reason to omit refs/notes/*?

No, I forgot about refs/notes/*. You probably also want to mirror that.

>> Its not a good idea to mirror refs/meta/config unless you want the
>> same access controls, *AND ITS REALLY NOT A GOOD IDEA TO MIRROR
>> refs/changes/* BETWEEN GERRIT SERVERS*. Yes, that last part is worth
>> writing in full caps.
>
> Because of the excessive number of refs to advertise for a non-Gerrit
> server, or what's the reason for the full caps?

The excessive number of refs is a problem for any Git implementation
(Gerrit included). But the all-caps warning is because of the way
Gerrit uses these refs.

Sometimes Gerrit scans the refs in a project, parses the change_id out
of the reference name (e.g. refs/changes/42/1842/1 is change_id 1842)
and then looks that change up in the database without matching the
project name. This can cause strange results, like an ancient change
in project Foo suddenly emailing its reviewers saying it has been
merged into project SekretThing on branch
NeverDiscloseThisToThatReviewerSet. We've had some pretty scary emails
get sent out because of this matching. :-(

Obviously this is a bug in Gerrit, when scanning the change_id data
from the references, we should at least double-check the project
names. But even with that check, two different Gerrit servers could
both create change 1842 (as totally different changes) in the same
project... e.g. if the servers each have exactly 1 project. Copying
the refs from one server to the other may overwrite or at least
confuse the destination's change data.

Until the refs/changes/ namespace is modified to be more dependent
upon Change-Id tokens and not the unique change_id sequence in the
database, copying refs/changes/* between Gerrit servers is not a good
idea.  (Though it is OK if copied from a master to a slave, they share
the same change database.)
