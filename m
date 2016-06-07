From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 15:11:47 -0700
Message-ID: <CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
References: <20160607195608.16643-1-santiago@nyu.edu> <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
 <20160607211707.GA7981@sigill.intra.peff.net> <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
 <20160607215536.GA20768@sigill.intra.peff.net> <xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
 <20160607220743.GA21043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: santiago@nyu.edu, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:14:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPEN-0000AV-1X
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbcFGWMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:12:08 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36231 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbcFGWMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:12:07 -0400
Received: by mail-yw0-f174.google.com with SMTP id x189so183617199ywe.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=irK7lFKtcj7hTgbpQTVVFS/iutPPbsk7fSLypGqlTp0=;
        b=bedonKQBh8W8sjmtJS1A7NtuKs1yZnY/H3iavXlRwSQ5t/5G7LqlxVxJS6f0YRQmcZ
         LID9sXbzn+5Xq49YPPRiSmyyefuIyuMBHXosmLujkrcoMg3zXq6Cx7ox37bOTEQQD5Hw
         wFDvb/UsD7N+wpBdVoim4iStDcqct+rkKs83pj4yeBun74rC/kofEaV0cNHFVcpzGEr5
         3G0wZEXjRCE4WZ8kuAL+jod+CszKecaca8xaB6ltNS0/bcRj4L/zfKMQqsaprutAua5R
         Yn/1i7NlISDEJ6s6hKVe+77HJ6+IhuqbsaC38FI0kLLRvlIzHNnfzJdr8cePhqdTSEIC
         Ln8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=irK7lFKtcj7hTgbpQTVVFS/iutPPbsk7fSLypGqlTp0=;
        b=if38/z7vcOp10ndcsFsVmpJRfWWNpQXq4Ni0Fuo7VkyGbCZ153UeC7KZOO2pATtZoN
         7Zgwb3KjI5GUK74/36adCnHLoz/EVFKtbjw3IDgsGMbwTYhqdUFFPZgQ19VFGXV3epuM
         9yZvxVAy7aQxoDp0YaICPZA4vOQNV42pvjfA+TjxxlfAjgXyySjEkeBdO1peyPMgu6hM
         YI8sA8fU45pcp/HS6+VZYZJuXG+vyo2j6T3ZEn6n9uEs+0tH1ZP7WshA5e4LJ0So8Lck
         F1UDooV0f9ViUZRyaKzUlSF16G0OP6iZnMQ1qu83P44TF/Va1JzFDGW4yUct88XOZ2J2
         W2aA==
X-Gm-Message-State: ALyK8tJAoY8vZ2kDelTgyJtxE4feu44liEG3yRk6gempR9jYifiz6wVqvJab6xhO0inzJ54N+hpwW8B8Yb0BnQ==
X-Received: by 10.129.146.206 with SMTP id j197mr1080320ywg.73.1465337526411;
 Tue, 07 Jun 2016 15:12:06 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 7 Jun 2016 15:11:47 -0700 (PDT)
In-Reply-To: <20160607220743.GA21043@sigill.intra.peff.net>
X-Google-Sender-Auth: dTLNBKuek1RKtOjOwSP-TbU6GyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296735>

On Tue, Jun 7, 2016 at 3:07 PM, Jeff King <peff@peff.net> wrote:
>>
>> Puzzled.  I didn't even use --format=%(tagname) in the above.
>
> No, but you used --show-tagname, which does not exist today (and which
> IMHO should be implemented as --format). Would --show-tagname take
> either a tagname _or_ a sha1? I assume it would not be calling
> get_sha1(), as having it find refs/heads/$tag would be silly.

And you do not even want to rely on where refs/tags/* it lives.
show-tagname, as I hinted in the first response, was meant to be
a short-hand for

       git cat-file tag $tag_object_name | sed -e '/^$/q' -e 's/^tag //p'

so I am still puzzled.
