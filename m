From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 23/23] checkout: retire --ignore-other-worktrees in favor of --force
Date: Tue, 07 Jul 2015 09:20:13 -0700
Message-ID: <xmqqio9w3poi.fsf@gitster.dls.corp.google.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-24-git-send-email-sunshine@sunshineco.com>
	<xmqqlhetyszz.fsf@gitster.dls.corp.google.com>
	<CAPig+cSSooqUcR_gW6vQP5Ws5v9p47bt7JWX4HgAyD6mFZynDA@mail.gmail.com>
	<CAPig+cSz3xS-pdtsiw14A80m7UqdwfGLy6kRdguHSUyAjfnWSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:20:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVba-0001TA-4v
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbbGGQUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:20:18 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35163 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757328AbbGGQUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:20:16 -0400
Received: by iecuq6 with SMTP id uq6so137733850iec.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dCy6+wcd9JJEs0ptLGWu27s+ZPSXy5so9oeOUaif7Ng=;
        b=JiFxRyVDXYKOeks8N6PHag3dYTdK5CwWc2eroYYETnj6xOUZebuIDw9bQ4vMm8uw+v
         l6LyPYW5gFRxd3qxG9nBECaD7c2pM0s091Jnzvu50aRjD3o8n0dxv/OqMue6oSTpHDj4
         IZHEGuQhuc0UmSmRqpPr40hVplZ9VQb0AI6BH5B69tVFmonYLfgGtif7MzbXRjnVTx7X
         2dMWu5xHf5dfTAfBv8VOOXaj6JEDlF2FzpjMkKgSJ2B0jEN71ovMuQcIFDDfn5wSifl0
         eqDtvZ2OyHj2Ld1K6oTdRzbdehbx4vcIy7Ou8fw5Y9+Id7jXnAxZlaCg/ZgrMdI6Nbfh
         ctcw==
X-Received: by 10.50.129.101 with SMTP id nv5mr56752504igb.31.1436286016149;
        Tue, 07 Jul 2015 09:20:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by mx.google.com with ESMTPSA id x83sm14906555ioi.6.2015.07.07.09.20.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 09:20:14 -0700 (PDT)
In-Reply-To: <CAPig+cSz3xS-pdtsiw14A80m7UqdwfGLy6kRdguHSUyAjfnWSQ@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 7 Jul 2015 05:41:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273585>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Is receive.denyCurrentBranch worth mentioning as an argument? Although
> pushing a branch into a non-bare repo where that branch is already
> checked out is normally disallowed, receive.denyCurrentBranch
> overrides the safeguard. Presumably, the user has experience and
> knowledge to know that "git reset --hard" will be required to sync
> things up.

Or the user knows that he does not have a shell access to the box in
the first place.  I do not see much relevance to this discussion.

I would not mind "git worktree add -f" to disable the "no multiple
checkouts of the same branch" safety, but I do not think it is
sensible to remove "-i-o-w" and conflate everything into "--force".
That would force people to disable other safety measures at the same
time (e.g. protect local changes from differences between the
current and next branches).
