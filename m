From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 7/8] update-ref: support multiple simultaneous updates
Date: Tue, 10 Sep 2013 18:51:28 -0400
Message-ID: <CAPig+cQ=PSQbF4+YfZC-Ps2Te47VNTRm_yDTVY48vGh4G2UFgQ@mail.gmail.com>
References: <cover.1378732710.git.brad.king@kitware.com>
	<cover.1378773895.git.brad.king@kitware.com>
	<74c081c4004f3a8afb38ab15aff7d3178de4a1f8.1378773895.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWmU-00009Y-4d
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab3IJWva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:51:30 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:45242 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3IJWv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:51:29 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so6768584lab.38
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 15:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=osLYUQJQqH1mtYJ0zjaCrn1nK4RxP/YC1mMg6gbEvAo=;
        b=l1plsCEB5Z8+hvueZSsFEW5YtbicVxDQ6n5luZqdXcbT6mG4el/jIp2HkjvQx2ERbJ
         1gpdUKg18S+HhAMC4v9VmbKVvHUqWTnH0M2h2mCLj/CBTS7+78p627dtxRrRuFIC7Kzm
         6k5mYS1zqlxc4Y6M3s1R6MF0ritvE1Z73hp23cvTA5JnRKk+w+g7xGlBVcmoGvVJM+Iw
         vMHCd3z/e+T3S7sTZkfhKIkXrWZvLjWfMEsEbpjLngLefRNoDE5RCagXhsDCN66UsiUT
         3RrPwKA+6/3/FtNLgJqcMVacl/ZPSYqhhu2syUr0WSDCnQ1Q7vD+v1ndbxwgs20xQn8q
         LJKg==
X-Received: by 10.112.9.195 with SMTP id c3mr89271lbb.33.1378853488173; Tue,
 10 Sep 2013 15:51:28 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 10 Sep 2013 15:51:28 -0700 (PDT)
In-Reply-To: <74c081c4004f3a8afb38ab15aff7d3178de4a1f8.1378773895.git.brad.king@kitware.com>
X-Google-Sender-Auth: 3G15QSN3ladc_XSsWH1KJ3S1Bl4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234500>

On Mon, Sep 9, 2013 at 8:57 PM, Brad King <brad.king@kitware.com> wrote:
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index 0df13ff..0a0a551 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -58,6 +58,58 @@ archive by creating a symlink tree).
> +option::
> +       Modify behavior of the next command naming a <ref>.
> +       The only valid option is `no-deref` to avoid dereferencing
> +       a symbolic ref.
> +
> +Use 40 "0" or the empty string to specify a zero value, except that

Did you want an 's' after the "0"?

0's
"0"s
"0"'s
zeros
zeroes

> +with `-z` an empty <oldvalue> is considered missing.
> +
> +If all <ref>s can be locked with matching <oldvalue>s
> +simultaneously, all modifications are performed.  Otherwise, no
> +modifications are performed.  Note that while each individual
> +<ref> is updated or deleted atomically, a concurrent reader may
> +still see a subset of the modifications.
