From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] apply: do not allow reversing a 'copy' patch
Date: Fri, 6 Feb 2015 15:39:46 -0800
Message-ID: <CAGZ79kbLGEmVWvDki9UefzX9zj8m+O9_nWH07WLxqTym4mptGg@mail.gmail.com>
References: <xmqqvbjed76s.fsf@gitster.dls.corp.google.com>
	<xmqqa90qd4iu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 00:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJsVC-0000Cx-74
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 00:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbbBFXjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 18:39:48 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37397 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbbBFXjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 18:39:47 -0500
Received: by mail-ig0-f180.google.com with SMTP id b16so6240600igk.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2015 15:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JsFKUXcey+eaQ+RGe9byup03q/eCqx3Lf+Fcwd0XcBs=;
        b=mD/xj5O9jK6aMQoW0kFdARx6NEb9pF7O+XWxbyTYIZNm51PDA6RKOWwovKF5WrB+un
         +P3hnKYJDsOKAKrr65iFDG3Vg6lXRPUPDC1V6ktzH+aoZ7wppLjg+q2dD0daiXj0PvY9
         kVw7P/kSrEwlo1FjHLJjNvqUykFb3sxydWJkozjVM0tT7DR32zOtj0DVlaFcmfg7PJ10
         VHAHph1oBrLF6lacr0qIn/ncYfWcZdN8AtUP7NgVMNBcN1ryrGx5LyV0N6sKzFEcSPCd
         tfv5IlBzZHDebHW6hcgswtHVcqNlNh3A00K7gKX3jxgt1YzYF7rXxoELlkSG5CBDlOY7
         zqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JsFKUXcey+eaQ+RGe9byup03q/eCqx3Lf+Fcwd0XcBs=;
        b=I481/Q5ewPPquu8ngYCwkvdpJX7P5ZTnZnEnBtIlK9wdhCCj3xMqZLJ7hRuAzHvhye
         BbxV28k9gIP5Xzf5DwqBmNJBF9NcHLdY7VlJOSlvgLRxtMUvOrkC8JpWzOi5O3t8eWyR
         lvL0ZxKRIL/YGc9zIcuIg52ahtV5EmcFhPWTOZ4gkk3UNPAFTNNIqOyHe0wX98rTTdCr
         gkH7H2nYTwRzMgdluBySiktnT8USWLUSmVJmyTp0lkNGqdNADKMRaq/21eWnVyy/2EdW
         IhFyjLtdoNrNMfoZW1qT9S4K07FpR/i7DuwGA8yFKGEsEuQP2VKc9vJzmFYXaw3/h7uB
         uT4g==
X-Gm-Message-State: ALoCoQman6OGZragTAi4mMQPZ3Uyv+SwTAwNovSQb7+uUbND6VmhRYp/Ladv+fU8HJfVwHGEZgrU
X-Received: by 10.107.16.169 with SMTP id 41mr13385141ioq.33.1423265986707;
 Fri, 06 Feb 2015 15:39:46 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 6 Feb 2015 15:39:46 -0800 (PST)
In-Reply-To: <xmqqa90qd4iu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263435>

On Fri, Feb 6, 2015 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> +                       die(_("sorry, cannot apply a 'copying' patch in reverse (yet)"));

Is it wise to give the reader of the output hope that this is not
implemented (yet)
but may be in the future?

I'd drop the "sorry" as well as the "(yet)" as the style of this error
message seems
to differ from other error messages in git.
