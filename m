Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A374068
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726689658; cv=none; b=VzTLk7Cjp+F2ecsT/8wwS+bUmw6Huyq9Y+4dhXWSkAKGcx7zVvvzfroHd7Jbc1FBRWtGMVDqiODwGfaJD3wS6TxKx4x0Zw1dTketS1Ki67rIUUWNQYZUedRDidGLFJ4E5o8egKXnQ7WSO4ti4CTTzwnwvzlHVBwNToXFEiR8rgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726689658; c=relaxed/simple;
	bh=EwRJiWgVb3868eSAN/f0ToUEJJyxR9JAxfUBtHjnEbY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtrA3MlkYV/yvIIFLQOJt6lXeaqMdM08JmFZ6eW3lWpdpy+Y/jTVljbXEJn6KBBRjIj8585b1hkwOfuvOrfuJ2UaaHNMPjr0KxWkodtsgikc+hO8Qf9LpbnqR0KF4VcymCJ4+pVRCV5XNYCQNHC9LqOOelYZHp8f67/GV8H49co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=v4U0GCO5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="v4U0GCO5"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dbbe7e51bbso607737b3.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726689655; x=1727294455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW1M09+YBeuqs8z4axcJ6Mi8rztMa4Xk4ya/DwkAhHU=;
        b=v4U0GCO5mSToH4pnAc1VfP0ouTB1G91lEKw+EzgROv63OY4VgOeAAYKDHE5RbHQe7R
         AyLpch1/gi88CkYC8XyUrfdmkNuQIrBbdpQSkoYS6KOHGJimWD4e5Ouf10+Ka4He7G62
         8NBC2BX+KaUykTvIZfTraZDMnRqfDLUaFi+Dm6SAcwlHDF9ME9vW67jYCqdVMx8uRFEI
         BKmWjQwsovqDJoAYjBmmx0ytKpBDTroLP7xopBGFpca7V74Z1ftYJtU/hwdq7HER3Pnq
         fDZBfZIIFZyIPBBX8gOjhL//uBDt5FAtMHFdKTWe93aseVhMM+mMyQjQre5JSkGOTOho
         PUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726689655; x=1727294455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW1M09+YBeuqs8z4axcJ6Mi8rztMa4Xk4ya/DwkAhHU=;
        b=nBy6bwLR4Rhvfh+XxprKmj+p7HcRzdQVHblQVB7yu/SNrl4Y4qRVZo6+xgZVofAdV/
         NiX9kUw3a95TYe2q/S1364+WYa7WQzyGCuPECv+qMwSrgFVjWhxsqKN1Q+VPT3TiZ0i0
         Hi3FPGlyws0MqaNP1wU128n7Efcdg2+O6d7nW+52LyE0s11Uqc77oQxf9MUUhY83pBDL
         Iw+Rc97WD+Abaqv9WM32aB4lDlKiL96WVz9O62AOKFc4uU20/lTGK7IgTWXhcz0P15Md
         hcHTdKsC7+TjT1C/zY1N61fZTVlGicN0MRPa4U2n6zmKFQBQUqNdYYa6ACn/bNpTSQYg
         HZiw==
X-Gm-Message-State: AOJu0Ywy7jA/Gbb9wpsXT7Qy+JAdr89q/7x+9aRTErAYPVfLzc7tytl9
	IftktA6yn/TCTuuhnqtuRWT2u8uhQjO9DiHPVOv2z3g1NlaOf/z61Ul6tFC/ao3CYyY1/VkP3NA
	/Gl2phA==
X-Google-Smtp-Source: AGHT+IEVeJKyhgrJPmHyx8AzzvgtXw+wO6ISPxhlj3F7JM2UbOCOH76pbErzTJN2dbC00EPfjCGF6A==
X-Received: by 2002:a05:690c:4c0f:b0:6db:d586:72d4 with SMTP id 00721157ae682-6dbd5867556mr157420097b3.18.1726689655131;
        Wed, 18 Sep 2024 13:00:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ddbb587ef0sm16906647b3.98.2024.09.18.13.00.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:00:54 -0700 (PDT)
Date: Wed, 18 Sep 2024 16:00:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: Git / Software Freedom Conservancy status report (2024)
Message-ID: <Zusxcweod1O88h7j@nand.local>
References: <ZurR5HGfhktqZPa+@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZurR5HGfhktqZPa+@nand.local>

Hi again,

On Wed, Sep 18, 2024 at 09:13:08AM -0400, Taylor Blau wrote:
> I wrote up a small update on the Git project's activities at Software
> Freedom Conservancy over the past year, but vger keeps marking it as
> spam-y.
>
> Instead of spending more time trying to figure that out, here's a link
> to a copy of that report as a public Gist :-).
>
>     https://gist.github.com/ttaylorr/cc41512caafefab110ad7a0b8a088750
>
> Feel free to respond here with any questions or comments.

Konstantin Ryabitsev wrote to me off-list that part of the reason my
message was dropped was due to my mail triggering the SPF_NONE rule, so
I have added an SPF record to hopefully allow this mail to go through.

If you're reading this, then that worked. Thanks, Konstantin! OK... here
goes:

--- 8< ---

It's that time of year again where Git Merge is upon us, so as usual
it's time to update our "Git at SFC" status report. This report is a
brief overview of our project financials, our activities at SFC, and
similar.

This email will serve as a report on the project's activities at
Conservancy for the year 2024, with new data displayed relative to the
previous report.

The previous report (from last year, whose format I've been trying to
stick to over the years) can be found at:

  https://lore.kernel.org/git/ZRHTWaPthX%2FTETJz@nand.local/

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

The most recent data I have this year is from 2024-09-18, so these
numbers should be more or less current (modulo outstanding
incoming/outgoing transactions).

We have ~$93k USD in our account, up ~$4k USD from where we were in
September, 2023. This was a modest year for the project's financials,
since the last report reported that we were up ~$19k year-over-year.
Average year-over-year growth we have seen over the past is closer to
~$10k USD/yr.

Here are some top-level ledger numbers gathered since the end of January
01, 2024. Note that this is all double-entry, so negative numbers are
good.

           $-21,554.09 Income:Git
           $-21,162.47   Donations
              $-391.62   Royalties
             $2,981.08 Expenses:Git
               $196.34   Banking Fees
               $675.96   Conferences:Travel
                 $0.00   Filing Fees
             $1,940.99   Hosting
               $167.21   Tax:Sales
                 $0.58   General
                 $6.80 Assets:Receivable:Accounts
               $325.00 Liabilities:Payable:Accounts
  --------------------
           $-18,573.02

Like last time, most of our money comes from donations. This year, ~1.8%
of it comes from royalties, which is in line with the proportion for
last year (which was closer to 2%). All of the royalties come from
Amazon affiliate links. 10% of all incoming money goes to Conservancy's
general fund (the above numbers are after that 10% has been deducted).

Last year we spent money ($675.96 USD) sponsoring Christian Couder to
attend the Google Summer of Code (GSoC) 2024 Mentor Summit. According to
my mails, Karthik Nayak also attended, but I haven't seen their expenses
reflected in Conservancy's bookkeeping, so they may have not yet
submitted their expenses for reimbursement.

We are still paying around ~$65 USD/mo to host git-scm.com on Heroku.
This cost is discounted from Heroku because of our status as an
open-source project. Our un-discounted bill would be something more like
~$100 USD/mo, and we receive $40 USD/mo as a discount. That covers most
of most but not all of the main Dyno cost. The remaining cost of our
bill is for the Postgres addon. I'm personally looking forward to
finishing the migration of git-scm.com to a static site hosted on GitHub
Pages so that we can eliminate this cost entirely.

# Trademark

We hold a trademark on the term "Git" and its logo in the space of
software and version control. The report from 2017 has a good overview
of the details there:

  https://public-inbox.org/git/20170202024501.57hrw4657tsqerqq@sigill.intra.peff.net/

There have been a few requests around our trademark policy, none of
which are all that interesting to share here, though I am happy to list
some of the details if folks are interested.

Two years ago Christian brought a discussion to the list about
rethinking the way we treat our trademark in the future, particularly
with respect to enforcement.

  https://lore.kernel.org/git/CAP8UFD3WQ64FuXarugF+CJ_-5sFNBCnqPE0AEBK-Ka78ituKTg@mail.gmail.com/

We haven't talked much more about this with Conservancy in the last
year, mostly due to a lack of engagement with the aforementioned mail on
the list. I imagine that would change if the discussion were
resurrected.

# Travel Budget Allocation

Nothing new here.

# Spending money

As you can see, we take in a modest but quite healthy amount of money
for an open-source project which has very few expenses. It seems that if
we did nothing, our account would grow somewhere between $10k to 20k
USD/yr.

I wonder if we should do something with that money. I could imagine that
it would be very cool to sponsor individual developers who want to work
on Git on a contractual basis, but can't due to financial barriers. (In
this imagination, I figure that whatever we do here would be
supplemental to programs like GSoC and Outreachy, which are focused more
on student projects.)

I would be curious if others have thought the same, or have their own
ideas on what the Git project could spend some of it's money on.

# Conclusion

That's all for this year. I'm happy to answer any questions on the list,
and I'll propose a session on it at the Contributor's Summit in a couple
of days, in case folks want to discuss this further in person.

I'm looking forward to seeing folks throughout the rest of the week who
are able to attend this year's Git Merge here in Berlin. See you then!

Thanks,
Taylor
