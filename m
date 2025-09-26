Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2B1F542E
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913923; cv=none; b=HCBzfCsUBUKCRXSJFaVmJmlnK1HtdNcZUE52kkdGQ9vhqgOdskvudCgFCQXQca7lL+DeWyR0lUPgvTHBDDBSk9+UOm00NmEbQ71jSa4QjcZ4vq8ZkuOAks3nVGw7FW5Joo79KXJKiAvg2A72zCX6LCIa5/5FPFnWIeWq0A1wwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913923; c=relaxed/simple;
	bh=3EYauaYkZucjieFQisxfR+MFQZnvLfqm+To33O0/9E4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b15l6AV0RqHdRAEODynUv4jSJ9vktLG//2cRz+p8CNhD+Sn4kQbcRYp5LPQNQz6D3aDOF+yvjrDi2s0ibE/PXJb26RTl2Nq32/2iEkKIPjfUYTu6tOJSERWwgOqRXU7EJb/bPito01AU63lwuqQ7Wtp6sJfqe+mx5tNgy4vIH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TArqI+fg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TArqI+fg"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d5fe46572so34142877b3.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1758913920; x=1759518720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=278hDRFbiGWXUbogW4XsKh6BbDKavf0puG9Puvfv4yM=;
        b=TArqI+fg4Lau0T5WFUHFueBB41Av19fz1XJHGNCMk1R2wbgKBteCPeHLV/GCpo2q0s
         SeFVbqz8m7Ux9VgHLtESd4YddVItIYJg8y+jqmvOq9r7dFnaeTaHZchDbi7f3Jc5B+xj
         sGN8ui+98DIh5zfb0SWhyBBYEYMWWu5fUg1QJWuH9hhLN8PtovQNfMhCqlvMd6Fya7Py
         /eILrumfxWRhRmzkfSID/p88sMGGU9EXWdLuRnRly1d0+8eyUJLJ37PBedVSScDufmU/
         SE+HfvYOKYk8uAm07k3T8P7qJGlWnZhzhPKGIpOAkk71hH/G7X+IsodmlX7iUMrMjFZK
         3/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758913920; x=1759518720;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=278hDRFbiGWXUbogW4XsKh6BbDKavf0puG9Puvfv4yM=;
        b=HasUMbzY+lSZck2vEC3Uu2AYjgQyDe0Wdc4sEItXw3QON5wj3SD1cOvMejsuWYq65T
         jiLm6xEscrCDYuV8qagOJbOyWm9FYXNFSVO8l79YImfK17ka50Y/js0UGLDMoAO3VGgd
         0s9wdF/uWd2Bw50Ouu4akCgM2vf8zzhis5wbPDN2/Nqb/CNGQvnycCM//6/NHY1NlKDm
         9cjeCbFA0+JJuGDR1MDjrkdg6UXMXfI2pRC8YlevH9in7xiR++H9ZtMjK5gfHL0ObFrE
         yc8eqRolS43FLVSpbQtkmhI13y07ZD25kr3tyZ27/RRc73/fRReujq3A4SQ67Da4xL/K
         f1uA==
X-Gm-Message-State: AOJu0Yxx5v3VYsfKCnFV3NMWtSDrY1QXBt0YxrRxpMPHYyyBxWIqckTo
	ZnjwKJrnBMRonnEzfjx0evAC4AbyAqebE5dW8+aTqN1ngZTOFXLKmulPpSMkXtevnyBuX6yiP7y
	truQ9U6g=
X-Gm-Gg: ASbGncvlOfRyF9HSGnAKfXhc4FW6QyjZIMG3n9qVB4jgmjBfiDcFZSpibqYWnUJhHdR
	cjrLiKkv6xqTN4w+HsXW/jYU5zYA94i5OQpr4KDYouozsIhR104pSHc7Y60tSAKTuHMzfIZFBnT
	sIytsOEgcjzKMsd0fhCxzQ1yrIIkd8byKa/P3Yk8qvv0n5dlKhIVFaiav9ULKbfHkowRr0dZePI
	S7p4XM+aTEu10/UqMvadie6hlHRUfLBxFwV+eCXYHJi2GFQEiZdK/rQ13NtRPFh2rvgRONQoXBQ
	VSYjFt4x2npNA4dDfXioNS6FyYn0Q8jMbD74lq50YJSV8wxPGU+13XE0ELlCrSRfsjP7+6mjjWg
	oiDgPbyVT1ZHzGnyJVpxTicT91RYdVBgagPJo9JJN1RoQr99jyeE52nrP8erUiRo8MWRWxeTvD/
	/VqCC3Bkf/05iQTGMMxsg8okws0nYa5wTc1RcM
X-Google-Smtp-Source: AGHT+IHGpoaliQGDTY2lNdZ6R0vaeiwfN55wsPUe5qPiXPMcPDnJGK7Y+AyMlRohsSphPr8nhSGaIQ==
X-Received: by 2002:a05:690c:110:b0:733:d35b:d7f4 with SMTP id 00721157ae682-7722cde624amr7878297b3.21.1758913919702;
        Fri, 26 Sep 2025 12:11:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6361e8c28dbsm1355860d50.3.2025.09.26.12.11.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:11:59 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:11:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Git / Software Freedom Conservancy status report (2025)
Message-ID: <aNblfuTDdtxLdImC@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

As we get close to Git Merge next week, I wanted to refresh the annual
"Git at SFC" status report. This report reflects changes in project's
financials and our other activities at SFC.

This email will serve as that report for the year 2025.

The previous report (from last year, whose format I have been trying to
stick to) may be found at:

  https://lore.kernel.org/git/Zusxcweod1O88h7j@nand.local/

# Background

Git is a member project of the Software Freedom Conservancy. The Git
project joined Conservancy in 2010 so Conservancy could help us manage
our money and other assets, and provide legal representation for
trademark matters. Conservancy doesn't hold any copyright on any of the
project's code. Similarly, being a member project at Conservancy does
not grant Conservancy any influence in the project's development. The
technical direction that Git takes is up to us.

Interested readers can take a look at a more full picture of what
Conservancy does for the Git project at:

  https://sfconservancy.org/projects/services/

A "Project Leadership Committee" (PLC) represents the Git project at
Conservancy. The PLC currently consists of Junio C Hamano, Christian
Couder, Ævar Arnfjörð Bjarmason, and myself.

# Financials

Since we don't have real time access to our financials, we rely on
Conservancy to send us snapshots of our ledger as we request them. This
report will share the financials from a snapshot taken on 2025-09-24,
which should be fairly close to where we are at the time of the
Contributor's Summit and Git Merge next week.

The Git project currently has ~$99k USD in our accounts, which is a ~$6k
USD increase from where we were around this time last year. Last year we
reported a increase of ~$4k USD over the previous year, so this year's
financials around in line with what we've seen in the past.

Here are the project's ledger numbers as they have changed since when I
last shared them as of 2024-09-18. Note that there is some back-dating
going on here for ledger entries that did not clear until after the last
report.

            $-8,466.35 Income:Git
            $-8,210.10   Donations
              $-256.25   Royalties
             $3,409.06 Expenses:Git
               $152.69   General (Bank Fees)
             $1,846.90   Conferences:Travel
             $1,250.00   Filing Fees
               $154.23   Hosting
               $112.50   Promotional Items
                 $5.24   Tax:Sales
                $-5.90 Assets:Receivable:Accounts
               $723.53 Liabilities:Payable:Accounts
  --------------------
						$-4,339.66

(As usual, this is double-entry, so negative numbers are good.)

Our balance as of 2024-09-17 was $-93,836.27 (not accounting for
backdated entries). Our balance as of 2025-09-24 is $-98,781.05. That
is a net change of $-4,944.78, which is better than what is reported
above. Despite my best efforts, I can't seem to account for where the
extra $605.12 is coming from.

Like last time, most of our money comes from donations. This year,
~3.02% of it comes from royalties, which is a little better than the
proportion from last year (which was closer to 1.8%). All of the
royalties come from Amazon affiliate links. 10% of all incoming money
goes to Conservancy's general fund (the above numbers are after that 10%
has been deducted).

## Expenses

More interesting is where we spent money. Like last year, the biggest
chunk of our expenses went towards conference travel. We spent more in
that category than last year (where we spent only $675.96).

This year we have a new pair of expenditures totalling $1,250 USD for
trademark filing fees, handled through Conservancy's legal counsel. $650
of that came from our Section(s) 8 & 9 renewal[1], and the remainder was
used to file a Petition for Cancellation against a third-party[2]. We
continue to receive requests to use the Mark in various ways.

We are no longer paying Heroku to host git-scm.com. The $153.23 we did
spend in the "Hosting" category was for one final month of Heroku, and
domain renewals for git-scm.com and git-scm.org. Hosting the git-scm.com
site on GitHub Pages is free, and saves the project ~$721.32 USD per
year.

## Future expenses?

The project continues to take in a modest but quite healthy amount of
money, and has very few expenses.

I continue to wonder if there are other ways that we should be spending
our money. If others have thoughts about what the project should do with
its money, please feel free to share them.

### Outreachy

The Git project participates in Outreachy, which is a program that
provides internships in open-source to anyone from any background who
faces under-representation, systemic bias, or discrimination in the
technical industry where they are living.

Outreachy suggests that companies to donate $10k USD per internship they
want to sponsor (previously this was $8k USD). The Git project has
historically benefited from GitHub and/or GitLab covering these costs
for us. We may want to consider budgeting for this in the future
ourselves, in case we want to take on more interns than those companies
are willing to sponsor.

# Trademark matters

As above, we filed two petitions related to the "GIT" trademark this
year[1,2]. The PLC continues to receive a steady trickle of requests to
use the "GIT" mark in various ways that are not compliant with our
policy[3].

I cannot recall us approving any requests outside of ones that did not
violate our policy to begin with. Over the years there has been some
light discussion on if we want to change how we treat our trademark
and/or if we want to alter the policy.

Nothing substantial has happened in those discussions, though others
should feel free to resurrect them if they wish.

# Conclusion

That's all for this year. I'm happy to answer any questions on the list,
and I'll propose a session on it at the Contributor's Summit in a couple
of days, in case folks want to discuss this further in person.

I'm looking forward to seeing folks next who are able to attend Git
Merge either in person or remotely. See you then!

Thanks,
Taylor

[1]: https://tsdr.uspto.gov/documentviewer?caseId=sn85961336&docId=S8920250131165809&linkId=3#docIndex=2&page=1
[2]: https://ttabvue.uspto.gov/ttabvue/ttabvue-92089369-CAN-1.pdf
[3]: https://git-scm.com/about/trademark
