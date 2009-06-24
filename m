From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: push.default???
Date: Wed, 24 Jun 2009 10:50:00 +0200
Message-ID: <4A41E8B8.8050803@gmail.com>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org>	<4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org>	<4A40D864.8040208@gmail.com> <20090623144805.GB24974@pvv.org>	<f865508f0906230932n4a2f2b54s1e76ab1d70d95073@mail.gmail.com> <7vprcu96td.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 10:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJOHC-00040L-M4
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 10:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbZFXI4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 04:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZFXI4H
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 04:56:07 -0400
Received: from mail-qy0-f193.google.com ([209.85.221.193]:65401 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbZFXI4G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 04:56:06 -0400
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2009 04:56:05 EDT
Received: by qyk31 with SMTP id 31so810970qyk.33
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 01:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=JbXageuivOekW4BoFCF5u9SiXkzFl9WNCuqyfX71sdc=;
        b=Iuz/MT/Gm4rWfCRqc9ySwvNSCj++jbmuLxQWQlBxr050a5CFthIVe8uqi6yov2PYfa
         /dPoKR5YgmdbLf7cxcrZepseS6GJBWNNKReAksdPVd3p6/5i3ioZO17mKAxBMdRzgBF/
         R5/HDzZRC0Tg4eC0E1JkfOUCXwhCKysA9cw0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=euHFir8KFGDf4Yr5f2QIhWvN58K4taeMNbz107e9k9L1D7n3EjTzJ2c9G4bI7OjuTf
         D1I8GyQ6OALEuHfmMiYBU/Yhzsw+yW7XzFoXxo9o5xj3B5E6BTHgFRvZtZUOX+8ujXIH
         BwLdC5zOzu+hP88SXCnK/K9+7oXBRveJUsQeU=
Received: by 10.224.60.149 with SMTP id p21mr841834qah.10.1245833412763;
        Wed, 24 Jun 2009 01:50:12 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 26sm1632507qwa.37.2009.06.24.01.50.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 01:50:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <7vprcu96td.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122133>

> You are forking off of shared 'master', but you are developing a feature
> on a separate branch 'feature'.
> 
> However, when 'feature' is fully cooked, before pushing it back to be
> shared with others in the group, don't you do any testing with the work
> done by others while you were working on 'feature'?  That means you first
> integrate your 'feature' locally into shared 'master' and make sure all
> fits together well.
> 
> Until you do that, you cannot be confident that the feature you developed
> is fit for public consumption.  But if you test after merging 'feature'
> into 'master', what you determined as good is in 'master', which you can
> push back to the remote's 'master'.

Here is what I think you are missing: in the proposed workflow, there is 
an entire group working on one big feature, so there is effectively one 
remote per feature.

In fact, what was not clear to me before Finn explained it is the way 
these remotes are configured and mapped to local branches.  In his 
setup, your own master branch is tracking integration/master, but your 
feature branch is tracking feature/master.  You're effectively using a 
centralized repository but splitting it across several remotes, 
presumably for two reasons: 1) access control, 2) so that people can 
choose which parts of the repository to mirror.

Mind that this is quite a mangled DVCS workflow :-) since you're 
distributing the centralized repository (!), so you're not using topic 
branches and you're not committing very often; if you were using topic 
branches you would have to use --no-track or risk pushing by mistake to 
feature/master.  You just map "svn update" to "git pull --rebase" and 
"svn commit" to "git commit + git push".

So, every time you finish some aspect of 'feature', you rebase it on top 
of the tracked branch feature/master to test it with the work done by 
others, and then push.  The rebasing is taken care of by "git pull", so 
it makes sense in this case that pushing to feature/master is done with 
plain "git push".

> Could it be possible that this desire to push "tracking" is not a cure for
> anything real, but merely a kludge to work around a misfeature of "rebase"
> UI that does not allow "integrate that branch here but do not merge it but
> by first rebasing it"?  In other words, if we had "git merge --rebase feature"
> [to merge rebased feature into master, then "git push origin HEAD"] becomes the
 > right thing to do, eliminating the need for "put my 'feature' into 
their 'master'".
 >
> For a group that sets up a shared public branch to be used for working
> together on some feature, replace 'master' with 'some feature' above, and
> 'feature' with 'your part of the work on the feature'; the story is the
> same.

I think this makes sense, but it is not what Finn was going after.  In 
his setup, there is no 'your part of the work on the feature', 
everything is done in a single branch.


Now, here is a plan to realize the same workflow with a different 
implementation.

1) introduce a new configuration key branch.autosetuppush that 
automatically adds a remote.*.push entry whenever a tracking branch is 
created.

I think this is also the right time to introduce per-remote autosetup 
keys remote.*.autosetup{merge,rebase,push}.  In fact I would introduce 
these per-remote configurations before, as a kind of "step 0".

2) introduce git push --current (or maybe --head-only) that uses 
whatever refspec "git push" uses, but always restrict pushing to the 
current branch.  This would only apply to "git push" without explicit 
refspecs.

3) introduce remote.*.pushHeadOnly to make "git push" always behave like 
"git push --current".

Note that the new command line option is not really needed, but it would 
make testing harder if --current behavior could be specified only with 
configuration keys.

4) introduce a --push option for "git remote add".  Every push.default 
configuration, thanks to steps 1 and 3, now maps to a simple configuration:

  --push=current -> remote.*.push = HEAD
  --push=tracking -> remote.*.autosetuppush=remote.*.pushHeadOnly=true
  --push=matching -> remote.*.push = :

In addition, --push=mirror could be implemented to do the same as --mirror.


I have a rough draft of all but the last step already implemented (I 
have not even compiled, but I wanted to measure roughly the complexity 
of the features; unless I screwed up big, it seems like a "calm" patch 
series).  I like this way more than the "magic refspec".  Unlike 
push.default, it builds entirely on the concept of refspecs.  But unlike 
the magic refspec, it fits with the rest of --track better, and it just 
uses two easily understood knobs to achieve its objective.

Paolo
