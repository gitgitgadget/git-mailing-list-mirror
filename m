From: Jim Cromie <jim.cromie@gmail.com>
Subject: feature request - telling git bisect to skip, from inside a commit
Date: Sat, 26 Mar 2011 12:48:25 -0600
Message-ID: <AANLkTinCiM9uqK8Yr=pKaeKytWXqpWF898AeTwvHKg4-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 19:49:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3YXp-0000Kd-2m
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761Ab1CZSs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 14:48:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33214 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab1CZSs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:48:57 -0400
Received: by iwn34 with SMTP id 34so2187878iwn.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 11:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=9QWCXrPerU6YoSzpzCC0Rw3aQUNFfs1K1Sem1O10Fzo=;
        b=VfCHKe3NK9yTFIccep4CGwVd490/zbBnuGoPQccdwWocOlMfw2JYQYEJHdmmHOlfSV
         Zk3YJbD4RW0azYZpo8g1EWYM/mF5O37c/6p5lJfsZGJs5QI9vqKlaDQEcMJxBVIovW9N
         FbIrq/a+iIQvH3bt5q4vJ5rmDbcOWjykmUQbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Jh8EOPDcdKi1H9CAuampMrrH0BlNo4rxWAzvl8n81/VuZQB245xopU8KcjYFIzoaBd
         mfU3waHWZ6SmKD2PP7FmeeX3vW1QRxFhINoXAfSUshezwm5ywjqTV2YaNd0LNPLXF/7Y
         gojnZcqbUvIghY8uGwt9ISNIobVjw1eDOzQDg=
Received: by 10.43.54.133 with SMTP id vu5mr3620290icb.36.1301165336574; Sat,
 26 Mar 2011 11:48:56 -0700 (PDT)
Received: by 10.42.114.200 with HTTP; Sat, 26 Mar 2011 11:48:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170069>

sometimes its feels clearer to devote a commit to changing (for example)
the definition of a struct;  and changing all users of that struct in
the next commit.
This isolates and highlights the definitional change, rather than burying it in
the middle of a huge diff.

The downside of doing this is that git bisect will trip over this 1/2 change.
It would be nice if a committer could mark the commit as not bisectable,
perhaps by just adding this, on a separate line, to the commit-message:

    "git bisect skip [optional range]"

the range presumably would be something like CURRENT^1
except that it would make more sense to flag successors than ancestors,
and of course, CURRENT would have to mean something.

Anyway, range isnt really needed, as any subsequent interim commits
could also flag themselves as such.

git bisect already has ability to skip a commit, this just helps an automated
bisection script.
