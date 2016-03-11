From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 00/48] Libifying git apply
Date: Fri, 11 Mar 2016 16:57:35 +0100
Message-ID: <CAP8UFD2nPe8MqESWm5Yug4dqdCp5QqyM9R0u1zwL29BkpdbToQ@mail.gmail.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
	<xmqqbn6nikn7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 16:57:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aePRe-00026f-0K
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 16:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbcCKP5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 10:57:38 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34167 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490AbcCKP5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 10:57:37 -0500
Received: by mail-lb0-f173.google.com with SMTP id xr8so156294806lbb.1
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 07:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DyeDKu86mNI2GJZHWLJ0DRnHzqCVE0wqkZ3XBej80lI=;
        b=iQ+YIdkk6RUMBplhsIrZh1L7b9NBDUyhnI/fUI2yZVnCn6PhgdqXdg8BlNcolc6Nqd
         xPinsGYtLPbluHEiDfY8FSKL8PaU8Aeb0V2d3dAVOqEVbZ++UIwpXrhlk3GxlC6yiHFi
         xUh41YKi0wsR28e0P6UqHmEB6Au5AsuA6RwKfcMP76AIctvSJEQ8iuebDlYBKAorrXKE
         d4Zh8p3TqRkBdb2e1wzdvDoLUywzw8nC5Dabbnf1Q0IcnhE+jcU/Zi9rBuJcsjX3tdvM
         uvs5Pi3N+RJehTC3OZLxJd65HqFST8vJZmmVX3rewdR3XVI2a8n2OnVsb1AOcr8UoUfw
         lv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DyeDKu86mNI2GJZHWLJ0DRnHzqCVE0wqkZ3XBej80lI=;
        b=DHfAGhJ/mk4FRLRGUmfVAzXMagTSBXh7ndnz9Fx9skeFigW9y71oYD7pI/QjK6CrwM
         FxoV0sPYfZxvH1Ht9zMQBMwqIrfA3rF5/bwuAI8J4xSJx2B2S4lhqW8EbdhqCRn9jJ/v
         RO1B0gvFYDukfU3Px9q9a8wBLAbzlH7NRawmer/tzrMRUYnb6dABF+vnlUIjqspq9m7Z
         oHzJGRzD9Jvx6CSTQ6+b8yyr+kXGYk4/YlNH38l3EzIBFK+9k5EKiLXI30l5/d46uwK8
         71ruxYN1mrdUris4sJzHZDQ2u9Hi02iZpU5F5zXrmWbdU8sL+l/ba9FU2AtyYNLCnSeZ
         s0oA==
X-Gm-Message-State: AD7BkJIFiAiZir81JWBgTEzFx8P68FMBPC4TEKzkuCGRFi+PihqhwaHl8o2/gHJqEdUmZ7zZKBe5JlSOdxjIig==
X-Received: by 10.25.8.1 with SMTP id 1mr2800161lfi.134.1457711855469; Fri, 11
 Mar 2016 07:57:35 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Fri, 11 Mar 2016 07:57:35 -0800 (PST)
In-Reply-To: <xmqqbn6nikn7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288688>

On Wed, Mar 9, 2016 at 7:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> One point I'd especially welcome feedback about is the fact that there
>> are many boolean options that are using OPT_BOOL(...), so they use an
>> int. And there are a few others that are using OPT_BIT(...), so they
>> use just a bit. I wonder if it is worth it to try to be consistent,
>> and maybe also to try to save some memory.
>>
>> Related to this, some of the variables for these options have not been
>> moved into the "apply_state" structure, because they are not global to
>> the file, but maybe for consistency they should be.
>
> These might be worthy clean-ups but that is only if they are done
> after we make sure conversion proper is done faithfully to the
> original, i.e. without introducing unnecessary bugs.  I'd advise
> against doing them before the libification is done.

Ok, I will try to avoid those kind of clean-ups.
