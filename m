From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] credential: let empty credential specs reset helper list
Date: Fri, 26 Feb 2016 14:13:55 -0800
Message-ID: <CA+P7+xoSPmvZp-3rgDc+JjuDKEdNvayPMM4azb2UgDaSk_gJ7g@mail.gmail.com>
References: <20160226105135.GA30215@sigill.intra.peff.net> <xmqqa8mnl71v.fsf@gitster.mtv.corp.google.com>
 <xmqqk2lrjmff.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Guilherme <guibufolo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 23:14:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZQeV-0004NG-JM
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 23:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbcBZWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 17:14:17 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37673 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbcBZWOP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 17:14:15 -0500
Received: by mail-ig0-f172.google.com with SMTP id z8so44905874ige.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 14:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A4rRGWVdZZ4EVTnfrjZvQwMRpOJV2PXUS5D+R066WV4=;
        b=n0+6JU3lrPMs7RonLRUOsSldkPeymuN1LDie/JiRAen4obHh+uO4gKgVgZjSmwLH/u
         zH7wIh3NE75hoU2kf2tT0lS6iY9NxSwOV0abx/8PAF0DlcBjk+uVKUIlSc5D5uRlE29t
         hmqvQG0PtH8OD3M42EV2NGfZwJBSG6JbWVvTYNVbbv4VuxUPXp7ikdqyHtgCcGSMPrk+
         4UyuX7qONc3ySZAubta6SXsnT1RH/VpzPuWj2ZsWaDn91GbUVUx5IHB5ObqKflXQhet2
         8bBEZqeihKbr8e1+2TEqJiye6UUSnzqL5xOxnmpgJsCYpVH2/3OPqpFbt7WV9iDjc0N+
         WwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A4rRGWVdZZ4EVTnfrjZvQwMRpOJV2PXUS5D+R066WV4=;
        b=C1JjqMPVixwYVQeS5xEP4DjHKZZLVWbFmI+6gQHXhLNNr6aAMvQEq0QDake6JaBiuK
         8ApRQbHa4pjEwZkS9liCnmk/BAAlaoDxm8FNrpWqxTZyt3jJobM6m1+UtwPhoc5DczkD
         Urd5XkvVBQpTuSAbqmCG/W2TUB5ri+6B544EdLDGmU5slF+7YCt/6nKw5Dl2puUvrPeU
         ffbCxk9CmXjnZRK5fusYijkuZ+MbxhN7XUOwxVoX7NZWFWMipeltJJnflty+EFQ+V5KG
         x8Lv24PXdChgvvJD2x8l/7a9ZcE2o0UIUYmcB7xOnyXSFX3MoQKZF75OQ2j/fmkFjyjS
         AIdQ==
X-Gm-Message-State: AD7BkJIElbEA425jnpuDpY3GbdutKkbhkBRJJRZKFzbL0h3KO1t6jTjhglXXnm2jJRuzY9/7iA7si+mkAKF7XQ==
X-Received: by 10.50.108.112 with SMTP id hj16mr205514igb.35.1456524854611;
 Fri, 26 Feb 2016 14:14:14 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Fri, 26 Feb 2016 14:13:55 -0800 (PST)
In-Reply-To: <xmqqk2lrjmff.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287627>

On Fri, Feb 26, 2016 at 11:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Of course, the code in the configuration subsystem for updated
> version of Git needs to become aware of the new syntax, and those
> that deal with the multi-value variables need custom code, which is
> similar to the way you special cased an empty value in the above
> patch, so I am not sure how much this would help.
>

For most cases, I think the previous approach of setting to empty
string makes sense and is more easilly intuitive, but would only work
for those values which the empty string has no valid meaning.

I would think either approach here is fine, and i think *most* cases
of multivariable configuration don't need to be cleared from within a
configuration file but only on the command line would be acceptable.

If we go this route I would prefer "-c !<config>" vs "-c <namespace>.!<config>"

Thanks,
Jake
