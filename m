Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDCE186284
	for <git@vger.kernel.org>; Sat, 22 Mar 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742682487; cv=none; b=IUBAdU2voIkkDLY9TH+igCGxgkG0ROrqbQ6NlG3jVew3fKGWW9xOy0zxjgmZElYS1nO1FOSEfVWTMcxfEjbE1byYBjd1lJY/jdDduRIhjNa0NGvrrllvijdOiubXKvZ30im3gxEFG7UR/6WXOdeZo2FWtFPBFC7eXIEZbzlUTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742682487; c=relaxed/simple;
	bh=gY+xTWx9aMg1d2IhumhW9W2YUUFAY6XGW78pmvp0vjk=;
	h=Date:From:Message-ID:To:Subject:MIME-Version:Content-Type; b=swJN8jrLa7UryQ1wrResX6J46jgyrswejNH/to4KKgu/JhQAwaeuGMx+VLgLx15ZWhWNMbGCIhImmP3ct+GTQlmv08bdgHCEAO0bRs2PHxa0YZEod7E6SpFOqiM7h1wfEuRqYcqI5c//yrqGW2inHd0FhvVHtNsbaSx3uRokdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=uVbGaxqQ; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="uVbGaxqQ"
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:7da2:0:640:6456:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id F247D60914
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 01:27:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uRV9UCcLoeA0-IOA17LeM;
	Sun, 23 Mar 2025 01:27:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1742682479; bh=dHyc7KD58+F/ahBmX7T9v0aQp3tWS01tLqf8M6oTaPw=;
	h=Message-ID:Subject:To:From:Date;
	b=uVbGaxqQdFuOVmvmW9ePrGU+3yq4hOeF/m2Zb/6vVObaT6J59qSXuHBQnGCjE/2ht
	 TTdTqNyx7QYpP0SYLUym9GFxUXjNFnS7Mi+1l/0csE8FuwxX0QqoQ/wNH9xxr9JPHI
	 Rm46Hh1tL2fCj1X6V52fD3abxmLu+RWhGkymHjPo=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date: Sat, 22 Mar 2025 18:27:56 -0400
From: Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1582116710.20250322182756@yandex.ru>
To: Git Mailing List <git@vger.kernel.org>
Subject: -w flag of git diff command hide lines which should not be hidden
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

I  got  merge  conflict and want to see changes ignoring difference in
whitespace.

>        -w, --ignore-all-space
           Ignore whitespace when comparing lines. This ignores differences=
 even if one
           line has whitespace where the other line has none.

From=20 here  you  can  see that not only white space was changed. It is
"name" -> "qualified_name" change.

But when I add -w flag those lines are hidden from the output.

Those lines should not be hidden.

Thank you.

```
 $ git diff -b --ignore-blank-lines --minimal /home/kes/work/projects/githu=
b-forks/sql-translator/lib/SQL/Translator/Diff.pm
diff --cc lib/SQL/Translator/Diff.pm
index 1d9ac40f,6c3e64a9..00000000
--- a/lib/SQL/Translator/Diff.pm
+++ b/lib/SQL/Translator/Diff.pm
@@@ -152,10 -169,10 +152,10 @@@ sub compute_differences=20
 =20
    my %src_tables_checked =3D ();
    my %src_tables_deleted =3D ();
-   my @tar_tables         =3D sort { $a->name cmp $b->name } $target_schem=
a->get_tables;
+   my @tar_tables         =3D sort { $a->qualified_name cmp $b->qualified_=
name } $target_s>
    ## do original/source tables exist in target?
 -    for my $tar_table ( @tar_tables ) {
 +  for my $tar_table (@tar_tables) {
-     my $tar_table_name =3D $tar_table->name;
+     my $tar_table_name =3D $tar_table->qualified_name;
 =20
      my $src_table;
 =20
 $ git diff -w -b --ignore-blank-lines --minimal /home/kes/work/projects/gi=
thub-forks/sql-translator/lib/SQL/Translator/Diff.pm
diff --cc lib/SQL/Translator/Diff.pm
index 1d9ac40f,6c3e64a9..00000000
--- a/lib/SQL/Translator/Diff.pm
+++ b/lib/SQL/Translator/Diff.pm
 $ git --version
git version 2.49.0
 $ git status
interactive rebase in progress; onto 1ef083ed
Last commands done (13 commands done):
   pick 354a27a9 Fix multiple arguments handling
   pick 1bfbcdad Introduce and use Postgres in-database schemas * Add CREAT=
E SCHEMA to DDL * Use table schema-qualified names where possible * Support=
 for diffs on in-db schemas
  (see more in file .git/rebase-merge/done)
Next commands to do (4 remaining commands):
   pick 5535f6a3 Fix tests after new layout for created functions
   pick 3c08c7c8 Add qualified_name's to MySQL producer - after table name =
parsing changes
  (use "git rebase --edit-todo" to view and edit)
You are currently rebasing.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   t/13schema.t

Unmerged paths:
  (use "git restore --staged <file>..." to unstage)
  (use "git add <file>..." to mark resolution)
        both modified:   lib/SQL/Translator/Diff.pm
        both modified:   lib/SQL/Translator/Parser/PostgreSQL.pm
        both modified:   lib/SQL/Translator/Producer/PostgreSQL.pm
        both modified:   lib/SQL/Translator/Schema.pm
        both modified:   lib/SQL/Translator/Schema/Table.pm
        both modified:   lib/SQL/Translator/Schema/Trigger.pm
        both modified:   t/14postgres-parser.t
```


--=20
Best regards,
Eugen Konkov

