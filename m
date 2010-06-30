From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How to Push a range of commits.
Date: Wed, 30 Jun 2010 15:47:58 +0200
Message-ID: <20100630134758.GC30999@debian>
References: <AANLkTikOffJHjzd3iBOXm7Lt7uPzHGkR1kfWtxSd-F9S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 15:46:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTxcP-0005Wb-T4
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 15:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0F3NqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 09:46:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43922 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab0F3NqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 09:46:19 -0400
Received: by gwb15 with SMTP id 15so356375gwb.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=MGmI971WtyvG6kOeAxNrfqEENf5D6cGudMnf8GEohZ4=;
        b=oLhiIX8GEZ6WAMydyqvIvByF/xV+ib2zq2qN9NiRznhpHusjKBdjlBqMJsVs/SwkWW
         vj0JfRsJi0xza22LjaSxtcwP19D9FCH19M3gvDY4z+NYoHTJghEX9q1IMnCdZTelpsr6
         8js+d7/biLiqjXlIOAK9VrnaH1jctFEIue9pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=nfV/ahX1TRhp27Sui6MHN4H5sVDelXgVFJ3NxI/tumqGCL9uu5KRbM5nk5NKdorszv
         ngwEereL/plOrhL5kpaNI93DHmC0YhrdP/fG4et1n8lqQc8qW118RZHGMMmj8MaIjHzj
         9LHcRq7SkiGzmZ9Xg4G1gDnMjniKTm7qyfzDo=
Received: by 10.213.22.201 with SMTP id o9mr435225ebb.89.1277905577529;
        Wed, 30 Jun 2010 06:46:17 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id w19sm8819727weq.44.2010.06.30.06.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 06:46:15 -0700 (PDT)
Mail-Followup-To: Mahesh Vaidya <forvaidya@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTikOffJHjzd3iBOXm7Lt7uPzHGkR1kfWtxSd-F9S@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149959>

Hi Mahesh,

Mahesh Vaidya writes:
> On branch 'foobar' I have a range of contiguous  commits  say C1...C9,
> C1 being at HEAD / TOP.
> 
> If I push branch all 9 commits will make it to authoritative
> repository.  Is there a way to push a single commit (as C9 or C10 new
> commit) which is common change set between C1 .. C9

Do you want to squash all the commits into one commit and push that?
If so, use the interactive rebase to squash them into one commit (in
possibly another branch) and push that commit.

If you want to push just a few commits instead, create a new branch
based on upstream, cherry-pick the commits you want into it and push
it to the upstream branch. For example, if I have a branch `foo`
tracking the upstream `origin/foo` and is ahead of the upstream by 10
commits, but I only want to push commit `bar`:

$ # In branch foo
$ git checkout moo # New temporary branch
$ git reset --hard origin/foo # Base it on upstream
$ git cherry-pick bar
$ git push origin +refs/heads/moo:refs/heads/foo
$ # I think the "refs/heads" part can be omitted in the above command

-- Ram
