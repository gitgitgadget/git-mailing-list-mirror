From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 3/7] submodule: check argc count for git
 submodule--helper clone
Date: Mon, 29 Feb 2016 15:14:03 -0800
Message-ID: <CAGZ79kY+AbOcwPnW2LSno=z8VueXgOgeB0O+MS_aOML7NNS0Cg@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:14:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaX10-0005Jp-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbcB2XOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:14:06 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34781 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcB2XOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:14:04 -0500
Received: by mail-ig0-f177.google.com with SMTP id g6so7544119igt.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=i9wbWylYxrLbc0AqqgG2S9ONghLtsqy5a+3xjKjybrw=;
        b=B1t0a3VrcP+ufVQMxztQBCL0ovbRvbjV6K2CJXIKes8cbMRuKCBTpgqVqeDQOgHGPU
         +m8zRNU0FWr5s5i34Kx1Ko7wkBFG4BjW+OJ2f4+hmOx5dS8JIbBQM2PGmBn+TzrEEAkC
         9o5Q9XaP5/OOzA967A6A44FXt8wiQeohEypjF2HTf/kP5JiKzAvOkrnYMjopVD8+cWsy
         2uYU0jf/6bPfBirtScGF5OMItyTUizKUzzCQox6osCL6Ts7X4LYGUCnWzxXNRSGL9tNv
         WFpyINFb+OMBiWiHaswGEt0W/3a4Bz7G/yzpeN56/brunbbYGqqKfIvp+IkfpIQBs1K1
         2n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=i9wbWylYxrLbc0AqqgG2S9ONghLtsqy5a+3xjKjybrw=;
        b=OpuPl33jB+VTJjWfKlGIcVMIeokpqm83N5WRUZTX20b2vk8CIiHFZUikqq4Ukiuk7M
         gikU6HUKmOfk1Sm4tP1Uy93BsF1qEt02REIcQmfNA7iJvpYvNdxzffPoDsQJ5/C3E/X1
         ULjon0ShCtSbxCJp5LG8+lSF/WL4xe+94/Kbnvq1yqNHl40mUlzv6+TC7+023mXnmQRB
         Kvk2+OxU+zN+WZFCj74LUgqeV8vvQwU5UwwXI38KY9Pht25dhsdKS/jxfUgvkgu4RRC9
         KcuvpCFADbE9yTHulyW2V0UE6QfUlHG1Y618f0Wu2uiD2tjuMjNTG4Wa+vaU0g9HrQOR
         ErYA==
X-Gm-Message-State: AD7BkJIBNDkNKtI2uqcFQtI9bjhyFfp0HPgewrq9diXFWdTnzr8i0W72owyFkNj0OW8y3GQmAXVh4oTwzb4b/XXV
X-Received: by 10.50.112.10 with SMTP id im10mr438375igb.93.1456787643080;
 Mon, 29 Feb 2016 15:14:03 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 15:14:03 -0800 (PST)
In-Reply-To: <1456786715-24256-4-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287934>

On Mon, Feb 29, 2016 at 2:58 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> Extra unused arguments to git submodule--helper clone subcommand were
> being silently ignored. Add a check to the argc count after options
> handling to ensure that no extra arguments were left on the argv array.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
