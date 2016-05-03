From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 63/83] builtin/apply: make apply_all_patches() return -1
 on error
Date: Tue, 3 May 2016 15:01:16 +0200
Message-ID: <CAP8UFD3NXo4vMBK9-3LChWcoSj7y_nKeea-RLyGmdy7kVvhabA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-64-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cSVCDNRup95ay=htiXiw0UCGs6boDuqovGnQJY8imbFhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 15:01:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZx7-0005pw-I7
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 15:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933431AbcECNBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 09:01:20 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34085 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762AbcECNBR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 09:01:17 -0400
Received: by mail-wm0-f53.google.com with SMTP id v200so28385788wmv.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=WpJcaRWUP7ZfggkJCO5Rd/m/r0Xvf1XSRRpwMhPXUW0=;
        b=vRUJndd8J6gpCfXr6bSI4RVHiGj/gRgpa8yB7KTGdVTJLiyQvfBCMDNWZQr0ulm9uz
         iEpi2o2digmylOZaWxszE+s7HwBj+mBDWGUqb8LiJPCSgi8967cl0WGqZ4eTjJN5Pp7g
         HnNlFyp7aZ5RzKhNffRuqOG/TRPM0oFc822KpOqdV3fmf0wlaLLntmv4Wo1nn6RymeE7
         klbCM+KbdIYZDdJxyCC0zDSqFeYCKfhhKRfHeoXYMu0fCL/vrzE+nxLFB8L3LxZehKoa
         EDj/Nzq+9SuFSiLe0YqrrTu+3UF8G3xcwDidaW8C4BLbI+GYc44fY6U/4VInHy+8w9d8
         M9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WpJcaRWUP7ZfggkJCO5Rd/m/r0Xvf1XSRRpwMhPXUW0=;
        b=Eilwji4yLolDAZVIYFZOl+24iLZ8+Rz5jDZrpwBpY3JWacbUmJn7rDpm4zPKsGrZyw
         Byqd8cRb2sS4s+Qe5L4Ay6bMJ3XEcjQVPNx4cQPIg1TcxzApVuaRe4f8qEcUBhVAD22X
         tXnQwoC38AS/4TwlkRLIRGBt5DhPBB4CXZ7atEPGK3OZh/LaM/B8WhwSfRfOxdiSp4iX
         T4Es4RusqbJVAPbyIfavc+HzLA306xXiG1gvRAdMEOmnpQr2pu/kM7oLXh4lhFY9QKpx
         kygxo52ugfNeNCeJLtVP8R5b8V8gIrI0y9TWG9M8E4sQRkAXpsjO+sD3Ec36alA6qi1L
         foBA==
X-Gm-Message-State: AOPr4FVU3Tn9g54Z6FIuUVzE3KJeMgfBJbBlrf696gP8+eABZA7gQtkP9ziddXp6ZNZdZfuie5KgI2jfguth9Q==
X-Received: by 10.28.151.133 with SMTP id z127mr3140855wmd.79.1462280476108;
 Tue, 03 May 2016 06:01:16 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Tue, 3 May 2016 06:01:16 -0700 (PDT)
In-Reply-To: <CAPig+cSVCDNRup95ay=htiXiw0UCGs6boDuqovGnQJY8imbFhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293398>

On Sun, May 1, 2016 at 11:03 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> @@ -4590,10 +4590,10 @@ static int apply_all_patches(struct apply_state *state,
>>                                 squelched);
>>                 }
>>                 if (state->ws_error_action == die_on_ws_error)
>> -                       die(Q_("%d line adds whitespace errors.",
>> -                              "%d lines add whitespace errors.",
>> -                              state->whitespace_error),
>> -                           state->whitespace_error);
>> +                       return error(Q_("%d line adds whitespace errors.",
>> +                                       "%d lines add whitespace errors.",
>> +                                       state->whitespace_error),
>> +                                    state->whitespace_error);
>
> How does this new 'return' relate to the logic below which updates the
> index? Does the index need to be updated here now too?

I think it is the right thing to do not to update the index when there
are whitespaces and state->ws_error_action == die_on_ws_error.
