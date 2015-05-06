From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 2/7] t5520: implement tests for no merge candidates cases
Date: Wed, 6 May 2015 14:06:47 +0800
Message-ID: <CACRoPnQMAsy3=VoOkjF61QujPMa0L=WmMXqLHakcoyjxaSRx6g@mail.gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<1430581035-29464-3-git-send-email-pyokagan@gmail.com>
	<vpqvbg8u5sq.fsf@anie.imag.fr>
	<CACRoPnQ5EaCmO-tmDxmNW_snFLbFNOq06wdF_p4FPHHv+HiJBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 06 08:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpsTx-0005op-G4
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 08:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbbEFGGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 02:06:50 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35760 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbbEFGGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 02:06:48 -0400
Received: by labbd9 with SMTP id bd9so143886311lab.2
        for <git@vger.kernel.org>; Tue, 05 May 2015 23:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iWQQ1SeebXarsI5yunwAPJ4UMPCZbF+GgQ09sphBu8I=;
        b=xVqfX70bm6DuYz/rA004oK9fPrZM2Nbjf8UfSuCDIwAJyv01ZGTNnBr4HPQaYkCEY4
         jwI7JbOsn3GE6WF1jnw28wu4b9J0fa2utsy1XCGJBENGnG3iRqZ1VU/x3/d/BiYtgHLo
         vHBiy0qC9liFK39BC69tkY24iZxs+eg/mt9rxjchAAUsa+5eVzfPd/ak3kpYtBh3R7iF
         HLx8mKAeto+8CdExB0lFbSmdFanACTJjbiutWI33vbWQStroxQdZw/N08l2DgvYDsZNg
         9tyCCo8ymbFoa3ChD5x0DWKR8WesmYh6X3BRM2eQ+Z7ZuCiVv6CHDoRkbbbdi7oL+XZt
         5kfQ==
X-Received: by 10.112.171.101 with SMTP id at5mr27342159lbc.66.1430892407225;
 Tue, 05 May 2015 23:06:47 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 5 May 2015 23:06:47 -0700 (PDT)
In-Reply-To: <CACRoPnQ5EaCmO-tmDxmNW_snFLbFNOq06wdF_p4FPHHv+HiJBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268450>

On Wed, May 6, 2015 at 2:04 PM, Paul Tan <pyokagan@gmail.com> wrote:
> Ah, I just figured out how to trigger this error. Just for reference,
> before I forget:

Whoops, hit send too early.

The test for case (1) would look something like:

test_expect_success 'fail if not on a branch' '
    git remote add origin . &&
    test_when_finished "git remote rm origin" &&
    git checkout HEAD^{} &&
    test_when_finished "git checkout -f copy" &&
    test_must_fail git pull 2>out &&
    test_i18ngrep "You are not currently on a branch" out
'
