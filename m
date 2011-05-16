From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: ACLs for GIT
Date: Mon, 16 May 2011 09:28:17 -0700 (PDT)
Message-ID: <m3oc32zk4a.fsf@localhost.localdomain>
References: <4DD02876.1040404@bbn.com> <20110515201513.GA27758@jpl.local>
	<4DD1250D.50005@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>,
	git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Mon May 16 18:28:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM0eg-0006qr-Hm
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 18:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab1EPQ2V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 May 2011 12:28:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58834 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab1EPQ2U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 12:28:20 -0400
Received: by fxm17 with SMTP id 17so3201511fxm.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=ZhzZ7u/zAVbbz/Y0juf++68bt/VbqJ4aG4at6KWZ7Hw=;
        b=pdnZekP8WVfBgkCon4d090RRR4izyzC8/DINhWtNj6Pa7OUbFST4IjTnGG65kPhRS4
         6jy8P7h26GAkbwyWLyJ3KAqgzJBEVgtCXcLziZuu3CSNNhAK1Qyq0630sS+gDvHH6HRY
         /UX1xiFjixq13MH3HVWoB8NclSTXEcmP1EpIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Z4Z9yQtUyJQKp89tOoXSOSdwgQ6z3CyZd+kBmmsCS+8/w8SXCULmvKkhWwJnSXzwCw
         A3WSU1too47Ga+TbZbSeNEvtlc47mdAQSQ/40ykOSgj11nS1KILFm2kfvDxk9ql/RcCu
         vWo0wX/8cQGmSeU6YmhVrB97YdvQm+Xd32dGY=
Received: by 10.223.40.85 with SMTP id j21mr4319749fae.22.1305563299471;
        Mon, 16 May 2011 09:28:19 -0700 (PDT)
Received: from localhost.localdomain (abvo158.neoplus.adsl.tpnet.pl [83.8.212.158])
        by mx.google.com with ESMTPS id c22sm1916718fat.38.2011.05.16.09.28.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 May 2011 09:28:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4GGReJX028940;
	Mon, 16 May 2011 18:27:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4GGRIZd028933;
	Mon, 16 May 2011 18:27:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4DD1250D.50005@bbn.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173746>

Martin L Resnick <mresnick@bbn.com> writes:
> On 05/15/2011 04:15 PM, Magnus B=E4ck wrote:
>> On Sunday, May 15, 2011 at 21:24 CEST,
>>       Martin L Resnick<mresnick@bbn.com>  wrote:
>>
>>> Is anyone working on adding access control to GIT ?
>>>
>>> I'm looking for the Subversion equivalent of mod_authz_svn.
>>> I need to restrict read access of ITAR documents that are
>>> scattered throughout the source tree.
>>> This restriction would need to deny fetch of the ITAR
>>> documents yet allow fetch of any other files.
>>>
>>> Looking through the source code it would seem that
>>> putting a hook call in the fetch-pack code would do it.
>>
>> I doubt it would make sense to put per-file permissions in Git
>> as it doesn't version files but the complete state of a workspace.
>> Even if you manage to hack the pack code to not include certain
>> blobs when certain users ask for them, what would those users
>> do when they want to create new commits based on commits where
>> blobs are missing? Or would you send the protected blobs but
>> replace their contents? Then Git would complain about that.
>>
>> However, both Gerrit Code Review and Gitolite offer per-branch
>> permissions, so if it would be possible to put these files on
>> branches of their own these tools would help.
>
> You pointed out some hurdles I'll have to think about
> (blocked files not matching the SHA and so can't be committed).
>=20
> As to why I want to do this consider NSA non-export rules.
> Our application would be built with NSA encryption
> but we have foreign nationals working on the code
> and so they are not permitted to see that part.
> The makefiles look to see if the NSA encryption code file
> is there and link it in. If not a stub is used.

You have to remember that with exception of submodules, which can be
fetched or not, all operations between repositories operate on whole
tree basis.  The commit in Git (i.e. a single revision) always contain
_all_ the files in repository (with exception of submodules).

ACL in e.g. Gitolite allow to refuse push if there are changes to
specified paths (per-file access control), but it wouldn't and
couldn't preent from viewing such "restricted" files.


1. What you can do is manage two unrelated branches (without common
ancestor one orphan to the other), "private" and "public".  You do
public work on branches starting on public branch, and merge both to
public and private, and you do private work on branches starting at
private branch, and merge only to private.  The public publishing
repository (e.g. on GitHub or repo.or.cz) would have only "public"
branch, while private clone (e.g. on intranet, or on private
repository on GitHub) would have both branches.

2. Another solution that could work is to have stubs for "restricted"
files, and in private repository use git-replace mechanism to replace
those stubs with "restricted" contents.  Again in public publishing
repository you woldn't have refs/replace published, while in private
one you would have refs/replace and git would show "restricted"
contents replacing stubs.  NOT TESTED!.

3. As other wrote, you can have yet another solution: use submodules.
You would put "restricted" contents in submodule, and just not make
repository that makes submodule public.  What would be visible would
be only SHA-1 of contents in supermodule.  This assumes that you can
disentanle files into submodules (loose connection)...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
