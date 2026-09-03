Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D546A5FD
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440132; cv=none; b=fI7Vu+TVfP/FqD1jFW9SUBelUMrEDlDz/5quZ3z/2t9wFjRjFRMtTck3+118Ub+YecPKYfdchTvl5LBwlYhst9x0qTpho3wdt9oFOY1XNeEflhdcGt7jj7eeaVo60/dHNx6vJLFmFFJmIofXAuhGJnR9I/WUfF9Seqz0BehZ8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440132; c=relaxed/simple;
	bh=PboDIHgMGgk1CPRXDVRA32Qul2Zk0axjJA94jEDhMoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMjJTY/9lqQiiUaspxKEuNRh0/cGxd07aPRgW6SUi7FKqIPWVoha2eJwJQhGNeaxKx4JMI7dDxVUmqwkbs6N8QjZxk1P5z8AB/YX5M530CvGwkvONlYn+VKD+m3l02CgkrHYbp84j5VEq376Sg1wYVcL6YTOf8ujS8nPXfgkWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=FU/vgroN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="FU/vgroN"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-485850cf499so176876f8f.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788440129; x=1789044929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BABp5Wn2jCHEgIHKwS4+Ci4pZs/4w2mj5FC7QjaYBrA=;
        b=FU/vgroNBTHH7WB30I19UzNjSQtu1y70Hp/3g4YQVbAOZtq9udeP9x7Y5lZwIdOfUm
         /vk03QWTLWhRZjm84WaOArQ1OZWuvdtmwziiWEZY8yhc+VqX4uxrE+0xjT9I/iN1w+j+
         jmZOW1P/JbhKNdkTZ7DDGFDiMplPTA/nOSIH9uG0UdpExvIJPGQTjs/oNVEyScX1gqhl
         +axdwtDePB/mcu2z4UGheEv4ywtLmovOYYq3lKZOBKXGmkrVyX9bP9ueo3AI9/XhH1qC
         aRzihzJIu7N3F5pigKWWCcfhPvuNpcmHCoxOsMnC2A8NXEGt7gr/mES+sRgN+FbRQ5J2
         S9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440129; x=1789044929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BABp5Wn2jCHEgIHKwS4+Ci4pZs/4w2mj5FC7QjaYBrA=;
        b=SqmJvkos+gBt7YhV1YuXnQ6JkIWwsbB5uCd+lMNrM0H2KtlcUUcznEebTCSzOZzupf
         FQeQVJYM3SaoH3pLz9N4/+4mfPmwjBNkzFuTtlhCIMPOSKF9HOsapnQtssdBdk3V/VsX
         oBIAS24/p7HuCyDznON/oQFdSLoYRpnxXhNNfM9i2hFuX843yE0R6TlBNm6aPWBfqTc1
         i44G4mXrP4BDTfkteQIERRrNbWgE/zuxWe42nhMO8W8cyeaS8re9uLNtD0U1oFFnpHp8
         mIkcBZz0oWXR6TOU7bscyJ4kkXzjq9Cj7sxGAId26TBqYIYMl99r00xcyPf51pv6NwZb
         LblQ==
X-Gm-Message-State: AFuF++lbkzgj6CnecRdAmhi3KNR4F8V4lBktoCp+vGgsJrasLvS5lxRU
	Kle06r7vW4FET6NqWu7ulGAvlqNEgWEDTltKmkX68TxDDRWdUy4bS2pUMdjgR8HIbTZcwNrMVvq
	UVnYFjUQzBg==
X-Gm-Gg: AYBFou3CID9cNokMJUbTUEXQLfk8KkPWeHUk8QFjaOVpk9je+1gf5wUGSvgjLYd/Uon
	z14t3QxyPEhpE8BscYIn/8dekso2uFjpNLerKC5gM1xO4GLxX046SKu0bYH8wujQUnXG8Mt+5ka
	rF16sqh67pSS4q6mu1xNQTLjgz3lgNEUfOV7ba6Tq3HIsGkE2tIqzoZVbYPMYjlbGBOovtYoIl2
	vU3fex9N4qAPo/pQU2TMq9/dxzEy64tv6vA899aluGWHK/YnZe8pMJTkPvSOXAs3VZPqgESHiBT
	re0jct+4XqUMcsOEAoNj8X6cuqUCNOvXVwfs7DXVxNM7je9992dVYP2lOhyg5RkhhPXZzn5OZAp
	hnzULkOqKFpP4FGc9R02GVEH0v/gJuBs5GeEzIL/N2xA7TM4hk4nMr9M6kf+mwVY5M61ovGJdXR
	f4SmXc9OdHTQES3RdsCVzSvxswJbsXQ7WRmRmAdl3ANB8Lp09nwyJSk2s/o9nyzILqqE9H
X-Received: by 2002:a5d:6d52:0:b0:481:5167:abda with SMTP id ffacd0b85a97d-48488f06d5emr18123669f8f.9.1788440129069;
        Thu, 03 Sep 2026 05:55:29 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e81718sm13491911f8f.16.2026.09.03.05.55.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 05:55:28 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>
Subject: [PATCH] git-contacts: ignore blame boundary commits
Date: Thu,  3 Sep 2026 15:55:27 +0300
Message-ID: <20260903125527.67934-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-contacts asks "git blame" which commits last touched the lines a
patch modifies, limiting the annotation to the last five years. Blame
charges lines that did not change inside a limited range to the commit
where its traversal stopped and marks that entry with a "boundary"
line in the porcelain output, which the parser has ignored since
4d06402b1b (contrib: add git-contacts helper, 2013-07-21). The
boundary commit is therefore imported like any other, and its author
and the people named in its trailers end up in the list.

Such a commit usually did not touch the file at all. Blaming a change
to builtin/receive-pack.c stops on a commit that only touched
builtin/fetch.c, and its author is proposed as a reviewer while the
people who actually wrote the lines are left out, as the age limit
intends. Those commits also pad the commit count each name is weighed
against, hiding real contacts under the ten percent threshold. Over
the hundred non-merge commits below 3cb9185f65 (The 22nd batch,
2026-09-02), twenty-seven lists lose a name, nine of them becoming
empty because nothing inside the window touched the lines, and three
gain a name the padding had hidden.

Read each blame run to the end before deciding, and register only the
commits it did not mark as a boundary, so that a commit stays a
contact as long as some hunk is really blamed on it. Ask for --root as
well, because blame marks the initial commit of a repository as a
boundary too, and in a repository younger than the window that commit
did write the lines it is blamed for. The cut-off commit of a shallow
clone is parentless in the same way, so it still passes as a contact
inside the window, a wrong answer this change leaves alone. The manual
page says that every commit "git blame" mentions is consulted, so note
the exception there as well.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    Notes for the list, deliberately kept out of the commit message.
    
    Where this is written down, since it bears on how the bug survived.
    git-blame(1) documents the behaviour under SPECIFYING RANGES: lines
    that have not changed since the range boundary are blamed for that
    range boundary commit, with --since=3.weeks given as the example.  So
    the script has been relying on documented blame behaviour and reading
    it wrongly, not fighting blame.  The porcelain marker itself is not
    documented anywhere: THE PORCELAIN FORMAT lists author, committer,
    filename and summary, and mentions neither boundary nor previous.
    That is the likely reason the field was ignored in 2013.
    
    Why no --is-shallow-repository gate was added.  In a shallow clone
    blame does attribute the truncated history, and it attributes it to
    the cut-off commit, which is grafted parentless.  The marking is
    decided in blame.c: a commit is reported as a boundary when it
    carries UNINTERESTING, which is set either because its date is older
    than --since or because it has no parents and --root was not given.
    Since --root is now always passed, the age limit is in practice the
    only source of boundary marks this script can still see.
    Asking for --root therefore spares the shallow cut-off commit, so it
    stays a contact, and it stays exactly as false a contact as it was
    before this change.  Gating on git rev-parse --is-shallow-repository
    would only let the script pick a different wrong answer, and picking
    one is a separate decision from the boundary bug fixed here.
    
    On the window condition in that sentence.  The age test runs before
    the root test, so --root cannot rescue a cut-off commit that is
    already older than five years, and such a commit is skipped like any
    other out-of-window commit.  Checked both ways on a four-commit
    repository shallow-cloned at depth two: with the cut-off dated 2012
    the old script offers it and this one does not, and with the cut-off
    inside the window both scripts offer it.  That is what a non-shallow
    repository does with an equally old commit, and it is what the age
    limit is for.
    
    Why the skip is per blame run rather than global.  %blamed and
    %boundary are lexicals inside get_blame() and are rebuilt on every
    call, while %seen stays file-scoped.  One hunk's blame may stop on a
    commit that another hunk's blame attributes real lines to.
    Accumulating boundary commits across runs would suppress the second
    attribution too, dropping a commit that genuinely wrote part of the
    patch because an unrelated hunk happened to end on it.  Per-run
    state registers the commit as soon as any single run blames it for
    real.
    
    Running the script on this patch demonstrates the change, and the
    result looks alarming until you work it out.  The script itself was
    last modified in 2017, so nothing inside the five-year window touched
    the lines this patch changes.  The current script prints one name,
    the author of whatever commit sits at the five-year mark, and the
    patched script prints nothing at all.  The empty list is the honest
    answer: inside the window there is no contact to offer, and the name
    the current script offers was never one.
    
    Falling back to the boundary commit when the list comes out empty was
    considered and rejected.  Under git send-email --cc-cmd an empty list
    means no Cc line, but the boundary commit is a stranger by
    construction, so a wrong Cc is worse than none, and the list address
    itself does not come from this script.
    
    The three lists that gain a name gain it because the denominator
    shrinks.  For 429dd07aa0 the current script weighs each name against
    eleven commits, one of them a boundary, and Robin Jarry lands at one
    mention in eleven, 9.1 percent, just under the threshold.  Drop the
    boundary commit and the same single mention is one in ten, and he is
    printed.
    
    The 100 commits measured are master's history rather than maint's,
    which is where the recent traffic is.  The proportions do not move
    elsewhere.  Over maint's own last 100 non-merge commits: 29 lists
    change, 24 lose a name, 8 of those go empty, 5 gain one.  Over 300
    commits of master: 88, 76, 27 and 12.  In every sample the emptied
    lists are a subset of the ones that lost a name, and no list both
    loses and gains.
    
    An unrelated defect in the same file, left alone on purpose.  Every
    object-name regex in the script demands exactly forty hex
    characters:
    
    	if ($line =~ /^([0-9a-f]{40}) commit (\d+)/) {
    	if (/^([0-9a-f]{40}) \d+ \d+ \d+$/) {
    	if (/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/) {
    
    In a SHA-256 repository the object names are sixty-four characters,
    nothing matches, and the script prints an empty list and exits
    successfully.  This is also why the boundary branch added here tests
    defined($cur) first: the group header does not match, so $cur is
    never set, while the boundary line itself still matches and would
    otherwise index the hash with undef and warn under use warnings.  The
    guard keeps such a repository as silent as it was before this patch
    rather than half-fixing it.  Behaviour today:
    
    	$ git init --object-format=sha256 r && cd r
    	$ ... two commits, each carrying a Signed-off-by ...
    	$ git contacts 'HEAD^!'
    	$ echo $?
    	0
    
    That silence is there before this patch as well, so it is not a
    regression, and repairing it means all three regexes at once.  It
    wants its own patch.
    
    A second one, noted for the same reason.  Three subprocess pipes are
    closed without checking the exit status -- in get_blame(),
    parse_rev_args() and scan_rev_args() -- while import_commits() and
    mailmap_contacts() both die on a non-zero $?.  A blame that fails is
    therefore indistinguishable from a blame that found nothing.  This
    patch does sharpen the consequence without causing it: an empty list
    is now a legitimate answer, so the silent-failure case and the
    correct case look alike where before an empty list was already
    suspicious.  Still older than this patch, and still not repaired
    here.
    
    A third, and the cheapest of them.  The final loop prints keys
    %$contacts unsorted, so Perl's hash randomisation reorders the output
    between runs: five runs over the same commit here produced five
    different orderings of the same four names.  That makes the output
    awkward to diff and awkward to pin in a test, which matters if anyone
    wants to add the test surface this directory has never had.  One sort
    fixes it.  This patch does not go near the print loop.
    
    Based on maint rather than master: the behaviour has been wrong in
    released versions since 4d06402b1b in 2013, and SubmittingPatches asks
    for the oldest integration branch a change is relevant to.

 contrib/contacts/git-contacts      | 16 +++++++++++-----
 contrib/contacts/git-contacts.adoc | 12 +++++++-----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index 85ad732fc0..25a918ae92 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -62,18 +62,24 @@ sub get_blame {
 	my ($commits, $source, $from, $ranges) = @_;
 	return unless @$ranges;
 	open my $f, '-|',
-		qw(git blame --porcelain -C),
+		qw(git blame --porcelain -C --root),
 		map({"-L$_->[0],+$_->[1]"} @$ranges),
 		'--since', $since, "$from^", '--', $source or die;
+	my ($cur, %blamed, %boundary);
 	while (<$f>) {
 		if (/^([0-9a-f]{40}) \d+ \d+ \d+$/) {
-			my $id = $1;
-			$commits->{$id} = { id => $id, contacts => {} }
-				unless $seen{$id};
-			$seen{$id} = 1;
+			$cur = $1;
+			$blamed{$cur} = 1;
+		} elsif (defined($cur) && /^boundary$/) {
+			$boundary{$cur} = 1;
 		}
 	}
 	close $f;
+	for my $id (keys %blamed) {
+		next if $boundary{$id} || $seen{$id};
+		$commits->{$id} = { id => $id, contacts => {} };
+		$seen{$id} = 1;
+	}
 }
 
 sub blame_sources {
diff --git a/contrib/contacts/git-contacts.adoc b/contrib/contacts/git-contacts.adoc
index dd914d1261..725e2be6f4 100644
--- a/contrib/contacts/git-contacts.adoc
+++ b/contrib/contacts/git-contacts.adoc
@@ -37,11 +37,13 @@ DISCUSSION
 
 `git blame` is invoked for each hunk in a patch file or revision.  For each
 commit mentioned by `git blame`, the commit message is consulted for people who
-authored, reviewed, signed, acknowledged, or were Cc:'d.  Once the list of
-participants is known, each person's relevance is computed by considering how
-many commits mentioned that person compared with the total number of commits
-under consideration.  The final output consists only of participants who exceed
-a minimum threshold of participation.
+authored, reviewed, signed, acknowledged, or were Cc:'d.  Commits that `git
+blame` marks as a boundary of its search are skipped, since they need not have
+touched the lines at all, so a patch may end up with no participants.  Once the
+list of participants is known, each person's relevance is computed by
+considering how many commits mentioned that person compared with the total
+number of commits under consideration.  The final output consists only of
+participants who exceed a minimum threshold of participation.
 
 
 OUTPUT

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

