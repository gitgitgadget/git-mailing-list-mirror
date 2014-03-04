From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Tue, 4 Mar 2014 18:36:07 -0500
Message-ID: <CAPig+cTzOxn5t0JOwxQyVrU___QPAQvwHR-zqFccaEQw+mYUCA@mail.gmail.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 00:36:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKysh-0001BC-5i
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 00:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbaCDXgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 18:36:09 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:52001 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaCDXgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 18:36:08 -0500
Received: by mail-yh0-f49.google.com with SMTP id z6so266704yhz.22
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 15:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gfWkVJvMwiwcadXSiW0TgHp/ObmYz2mJ1w1xIE7vO0s=;
        b=vu2njmbg6vg/sjw/rqVkMQ8Om1phx40HRkqDVUhNP2qKEpQ8CQZ/CODjJeicKUG1ZT
         KD1ERCA9vhyfwKoPX4Q0WOLYGZFKVTO8T4zIO5+rtPGlKMmj+MERvPWhWq1bqwPEZSGN
         2T7S8PONYlWMS+TAFxF0WgzzkzNRfpedTcJj6FwcHfqwYTAvznU6rgv8lDjdDP7W7kNW
         dDUeOVizp4voQTg3FbLxdmI+3jaLQ0BLmK2NtBgjoSq92UTIyDFit6wTMD6agkAp5Qf4
         996g7pL64dx4eNUcqDri8nsf1PxKsRqFzx4+1tRK1sKtdUr6cr06OCUz1E8twWJezKll
         bObA==
X-Received: by 10.236.132.178 with SMTP id o38mr2859539yhi.44.1393976167864;
 Tue, 04 Mar 2014 15:36:07 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 4 Mar 2014 15:36:07 -0800 (PST)
In-Reply-To: <20140304174806.GA11561@sigill.intra.peff.net>
X-Google-Sender-Auth: -Q1g2QiRcGXytBUtshXANfkEGs4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243405>

On Tue, Mar 4, 2014 at 12:48 PM, Jeff King <peff@peff.net> wrote:
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..886dbfe 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -114,6 +114,11 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
>  static struct commit_graft **commit_graft;
>  static int commit_graft_alloc, commit_graft_nr;
>
> +int commit_grafts_loaded(void)
> +{
> +       return !!commit_graft_nr;
> +}

Did you mean !!commit_graft ?

>  static int commit_graft_pos(const unsigned char *sha1)
>  {
>         int lo, hi;
> --
> 1.8.5.2.500.g8060133
