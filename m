From: Emeric Fermas <emeric.fermas@gmail.com>
Subject: What's the definition of a valid Git symbolic reference?
Date: Mon, 14 Feb 2011 21:58:14 +0100
Message-ID: <AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=d8xkw7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vicent Marti <tanoku@gmail.com>, libgit2@librelist.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 21:58:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp5VJ-00006U-1a
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 21:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab1BNU6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 15:58:36 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43253 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab1BNU6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 15:58:34 -0500
Received: by pva4 with SMTP id 4so892665pva.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 12:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=sBji/lw+46AlnEPh8SkKXDNP36G9Uv7qi0/Xvs5Q2j4=;
        b=PHgKNlWnW7gwUiiEnOnFcxyuW1/RQTb7IkL4tM49XG27MdGb0FmvydiSc8hqrFwASG
         8k00n1HqznYTHeQl52ACtHL59XkG8NjN0X8l6k2eM7CLkXyFRMXkaa13MUEQNFdKcdmY
         MSQRX9c82vt47r37wxzjblsuWMJikPwfhNIH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=uqAYKBaeideEINiuJPtSTArL8djaHW8kn+hZek0F1R/9J/eiD3bU4QHRh48VF5aHU7
         psEWub84n7q1QXAjJvPO9w3S3Oe7Q1Z7vZpRpABCn69qjG3aj9wXNh5PNRnCvGfNeLE/
         La2aeCHrXNm6G47pdI1Mc6uOJ/0JHemWwikOc=
Received: by 10.142.174.7 with SMTP id w7mr3471140wfe.415.1297717114482; Mon,
 14 Feb 2011 12:58:34 -0800 (PST)
Received: by 10.142.195.18 with HTTP; Mon, 14 Feb 2011 12:58:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166765>

Hello,

I'm one of the contributors of libgit2 (http://libgit2.github.com/).
I'm currently working on the handling of refs and I'd like to get a
better understanding of git symbolic references.

In order to avoid polluting this list with an easy to answer noob
question, I firsty asked this question on stackoverflow
(http://stackoverflow.com/q/4986000). However, I do not have the
feeling that I'm getting some definite "carved-in-stone" answers.
This explains why I'm posting it here today.

The following shell code correctly creates a chain of symbolic references

  git symbolic-ref "first" "refs/heads/master"
  git symbolic-ref "second" "first"
  git symbolic-ref "nested/third" "second"
  git symbolic-ref "refs/heads/fourth" "nested/third"

And the following shell code correctly resolves the latest created
symbolic reference to the tip of master.

  git show-ref "refs/heads/fourth"


None of these use cases are described in the official documentation
(git-symbolic-ref doc, git-show-ref doc).

However, the following doesn't work

  git check-ref-format --print "first"


So, my questions are:

 - Is it ok to store a symbolic reference within the refs/heads directory ?
 - Is it ok to chain symbolic references ?
 - As check-ref-format fails when being passed "first", does this mean
that it's not recommended to create a symbolic reference at the same
level than "HEAD"? Or maybe this command is not intended to deal with
symbolic links ?

My intent is to get a clear understanding of what is being supported
and that I'm not working around anything or benefiting from a bug.


Thanks in advance for any help you could provide me with.

Cheers,
Em.


Em.
