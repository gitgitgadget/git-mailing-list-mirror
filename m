From: David Barr <davidbarr@google.com>
Subject: Re: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Fri, 6 Apr 2012 18:41:46 +1000
Message-ID: <CAFfmPPNHkK3SB8cGjfJiVoQoSg2OLL8B5--mwH8HShhJ1WGy2g@mail.gmail.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
	<CACsJy8A+cJtzKdqJSWbmjT1LgP10LB69-NHfOv8S6BusGcMeFw@mail.gmail.com>
	<7vpqbn8hgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 10:42:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG4kk-00042v-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 10:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab2DFImI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 04:42:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42049 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab2DFIls (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 04:41:48 -0400
Received: by gghe5 with SMTP id e5so1203171ggh.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=P0hNYWArPKgFZGP2+OlhQxKofStPqqP0/cKJ5KOojt8=;
        b=NJPpaxuqiWHfeVKtuRetz6hmvUcGSH52kil+CD2Wfe4DdueCgypSnRwKEDCEZBye/9
         Scg2GucLX2fiwp7vERZ43oIAMqPwcInd7byWNZuG1whnDH1FBflxVFmsqXBPXGlRg7C1
         03iKtY8RfFjU3COokyNM/aKIUb8PjBM05F11m9QNbxiR71O9lql5rkRu5/rd/LAJH01F
         JZfG4tmv+c+0KO839z65AGf5okTXurx54fSo/gaj8y4kY+5ulg+EHhj1NhhcmoarM5Nn
         B0E7HUwmOsIpn/BxAyG7CLvJK/6FB5B/0LmkI/Scp5+v2+hguNgFoWqvt/xF+VFiFCL3
         2mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=P0hNYWArPKgFZGP2+OlhQxKofStPqqP0/cKJ5KOojt8=;
        b=JIDvaA1HeQDw22eeMqExMdKHhKIkPeXA7GzzmfD+eJhFlJ6tOWAf8i8rm2lQ4NhvUv
         U3q8ldMF33oK0gbwuVyF7xP2nK7EWp87MOsoShCayArdwB9JqxbMpr6cxNgLubUcjDa/
         41zSy+gcU2jFdqwo9jZGmS2jTgHnEMNEQYBU6lBHr2n3/ebiOd6CfBxhnocTnuOCuFFg
         l/dSAmvW7dJquW14atGB1INZC3G7iTJQxoWOHBWlPVGwtdb/w3TmEcI/vBCqv4vb5u8D
         WwpzTw07K6kM8JrRQbQjsmGUb5qv22xeYsbTZL/2k0mLzDe23s0aA0DNN1I5TRD0Gp26
         CYoQ==
Received: by 10.236.170.198 with SMTP id p46mr6183041yhl.63.1333701707406;
        Fri, 06 Apr 2012 01:41:47 -0700 (PDT)
Received: by 10.236.170.198 with SMTP id p46mr6183015yhl.63.1333701706862;
 Fri, 06 Apr 2012 01:41:46 -0700 (PDT)
Received: by 10.101.83.5 with HTTP; Fri, 6 Apr 2012 01:41:46 -0700 (PDT)
In-Reply-To: <7vpqbn8hgr.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmiDfe7/XqYrMh0V2+OsnrMN7cvATU5jW3KjosI7y8tRDPaqhgVRT0D7bw/vjwE/q5TS3uZEIpBB4s1nNK9IFAjbSycw8X745f8n895QNI0qT0RlKjY8CIPcuT/PIuyRnoqucwmKKb+SSvrxkSV4GHLFdYW2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194862>

On Thu, Apr 5, 2012 at 4:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Wed, Apr 4, 2012 at 5:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> I wonder what causes user time drop from .29s to .13s here. I think
>> the main patch should increase computation, even only slightly, not
>> less.
>
> The main patch reduced the amount of the data needs to be sent to the
> machinery to checksum and write to disk by about 45%, saving both I/O
> and computation.

I hacked together a quick patch to try predictive coding the other
fields of the index. I got a further 34% improvement in size over
this series. Patches to come. I just used the previous cache entry as
the predictor and reused varint.h together with zigzag encoding[1].

That's a total improvement in size over v2 of 62%.

[1] https://developers.google.com/protocol-buffers/docs/encoding#types
