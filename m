From: Francesco Pretto <ceztkoml@gmail.com>
Subject: Re: [Patch] Documentation: enhanced "git for CVS users" doc about
 shared repositories
Date: Tue, 06 Nov 2007 11:04:30 +0100
Message-ID: <47303C2E.2070103@gmail.com>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 11:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpLIg-00022j-MY
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 11:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbXKFKEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 05:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbXKFKEh
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 05:04:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:58257 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXKFKEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 05:04:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1066137ugc
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=NashjXogkIyEeS+LwNXNqAgXbUZUsMGxHxT4wqG6cJ0=;
        b=EnaKlJYjcis2HopUOQRYZPdvxBkQefU4aG8j1dHIUL1lYU6ipAxToErhpaaVBkZ0npnpDEVXVh87K2EaOdCzRZvtcs0hZ87R45/ylgpJVARJGQ401sufh8SkRaO30fp2+Tse7KJQwGKnaQ3l3K1WbrWyTcAmOMWH4zYLPnfbDJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rjSpzi6wh1idqgTrjMq4zvqG/NPrKVNytTXDfIshfh23RHDkugU/f7RJNDOUyV2P1aHAGAmHwSQyosFKE7dhLcyQReBRuTquaJoeZH2z8i5mT65N/kFsdwXQdkXv/Tba5UGd9F1luzYyF7ny6J90M+Wn5aar8s21kqfa2gvtJH0=
Received: by 10.67.21.11 with SMTP id y11mr2517502ugi.1194343474076;
        Tue, 06 Nov 2007 02:04:34 -0800 (PST)
Received: from ?192.168.1.14? ( [87.0.185.143])
        by mx.google.com with ESMTPS id p39sm6118977ugd.2007.11.06.02.04.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Nov 2007 02:04:32 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7v8x5cmern.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63654>

Junio C Hamano ha scritto:
>>  ------------------------------------------------
>> -$ git clone foo.com:/pub/repo.git/ my-project
>> +$ git clone foo.com:/pub/scm/repo.git/ my-project
>>  $ cd my-project
>>  ------------------------------------------------
> 
> This part seems an unnecessary change.
> 

Ironically, that's the same configuration of git.kernel.org. And I think is better
to put immediately the project in a appropriate directory than to move it later.

> Don't assume the "admin privilege" part, as you do not have to.
> 

Admin privilege SHALL be assumed, as this is a first time configuration, and the best
we can do is to assume it's done on a default *nix installation. Moreover, it's
what HEAD documentation is already doing when it suggests to give users ssh access.

Let's suppose the user "user1" create its own repository on a remote machine.
Now, he wants to selectively give write access on its repository to "user2".
There's 2 cases:
    1) "user2" have a local/ssh account on the machine. In this case, "user1" want
       to be sure only "user2" can write to the repository, so he can ask the admin
       to put "user1" and "user2" in the same group "projectx" or ask him to enable
       ACLs, still turned off in the majority of *nix systems.
    2) "user2" haven't a local/ssh account. Here:
	- a local/ssh account should be given to "user2", returning to 1)
        - mod_dav module has to be enabled for public http dirs of "user1"
        - git daemon has to be started and enabled to write on the repository.

The last 3 tasks all require admin privilege on default linux/bsd/macosx
installations. However, a little distinction can be made. I'll see.

>
> needs, and there is no reason members of projects A and B should
> be in the same group 'git'

I agree!

> while having members of project C in
> group 'hg' only because A and B happen to use git.

I agree!

> belong to 'src' group, or (2) make three groups, one for each
> project.
> 

It's exactly the point of:

+It's recommended, but not necessary, to create a specific group of commiters
+for every project/repository. With root credentials launch:
+
+------------------------------------------------
+$ groupadd $group
+------------------------------------------------

What you have understood here?

> Also with the "create new --shared repository for the project in
> a group's directory that has mode 2755" approach, I do not think
> there is any need to muck with umask either.
> 

umask requirement is referred to previous version of git. It's still referred as actual
in HEAD documentation. If it's ok for you, we could just cut away that reference.

Conclusion: i can try to amend my patch to be even more clearer. What i am saying
is that official documentation, commands manuals/syntaxes should be easy enough to the
first time user to set up git repositories without looking up the web for
"git tutorial"/"git installation"/"git umask 002", etc. (and consider that even an
expert sysadmin is a first time user, when he install and set up git the first time).
Or was better a "Documentation S**KS!" bug report?
