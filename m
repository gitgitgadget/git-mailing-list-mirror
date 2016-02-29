From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command line
Date: Mon, 29 Feb 2016 15:39:28 -0800
Message-ID: <CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:39:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaXPa-0002T5-7q
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbcB2Xja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:39:30 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33548 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbcB2Xj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:39:29 -0500
Received: by mail-ig0-f172.google.com with SMTP id y8so7901760igp.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4PrpQa4lvk06ErB9j8Hi0QbBDs6TimF+BdbqNYSkP7Q=;
        b=o0PCY7/mOaGDeNPPDZyrjXq5lCw5b2YlKY8vfT6i7xw/FpcmoBTagrUR7JlCTF1jzW
         U1aXM8UNdlhLx6LxXeuejb1iGXJMGraUfz8YSROqoAy4svg0X/nS5lthsGvBY2O8TPFf
         lxlmCaGII6787bmduyt2Nf+yn6FaYx0iY7ottnOJuaBEhw+QlfLoFZUIgLUNutOgBl2V
         7ROW5VOtgNQhoHY4b9J5rit2bMQkN9K2sGkn0IjekQMYNqLP0VIfIxkrBKh6sEZ8+laO
         KNDmgt9xNIDARO0GmCD863ILGsbHBSWMKtjlfnftK4OkY8UoJZCVtQLueeApHH1M6QrL
         /PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4PrpQa4lvk06ErB9j8Hi0QbBDs6TimF+BdbqNYSkP7Q=;
        b=kRUvR0fboM1p575cgWE2/p1c12MRswemEaQ71YoDEE2P4VBoFZOwAZu6IxbJiuvmE1
         ryzCfT0OVY57eNBSwXgMOjTJx7A/hmg/6cbrao6p70/9tDncjxFEnHAMp3QO2h4R30g+
         lBL35DIwVK3epf70p/gEE3avcgRWfnTbKoc6YrfEJS/GSvh0UIsn8iVYXQhggmWC33RL
         iSkPTfqEHUuOBeV9qbw/1fUjoDzPNzm+ho/Yay2/CRzSpHHAlmWpV21BV/ND5rUxm4pr
         Q9wEnVGjY/2dtP9TGlwaUYmPCoMVxhxphlCYYxPFWZepb/Esq7F/V9J7xiLmoPYt6wIc
         cQFw==
X-Gm-Message-State: AD7BkJKugmuC6/h3MpnuDZT/au0sM8RcrAfhr3PtFXTQ1xL8ISm1uwFJnsgDLndNQtcwUoyuX3uq64w5iQJCqz5v
X-Received: by 10.50.3.42 with SMTP id 10mr509229igz.85.1456789168520; Mon, 29
 Feb 2016 15:39:28 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 15:39:28 -0800 (PST)
In-Reply-To: <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287940>

On Mon, Feb 29, 2016 at 2:58 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> +test_expect_success 'cmdline credential config passes into submodules' '
> +       git init super &&
> +       set_askpass user@host pass@host &&

I wonder why we use pass@host as a password, it seems confusing to me.
p@ssword would have worked if we wanted to test a password containing an @,
pass@host doesn't quite fit my mental model of how passwords work.
No need to change anything, better be consistent with the rest of the tests.


> +       (
> +               cd super &&
> +               git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
> +               git commit -m "add submodule"
> +       ) &&
> +       set_askpass wrong pass@host &&
> +       test_must_fail git clone --recursive super super-clone &&
> +       rm -rf super-clone &&
> +       set_askpass wrong pass@host &&

Why set set_askpass a second time here?

> +       git -c "credential.$HTTP_URL.username=user@host" \
> +               clone --recursive super super-clone &&
> +       expect_askpass pass user@host
> +'

Thanks for this test!
Stefan
