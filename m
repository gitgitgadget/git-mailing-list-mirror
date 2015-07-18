From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 17/18] rerere: use "struct rerere_id" instead of "char
 *" for conflict ID
Date: Sat, 18 Jul 2015 04:47:59 -0400
Message-ID: <CAPig+cRGskV_meE4Fn0FFU-96HJx1yQuEg5zOA2g4N+3+7c4Kw@mail.gmail.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-18-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 10:48:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGNmz-00030U-4w
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 10:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbbGRIsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 04:48:01 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34353 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbGRIr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 04:47:59 -0400
Received: by ykax123 with SMTP id x123so106971385yka.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TpybTCvwBM+aZaScwcMBZunrCSKGMvnXTtSNHfZGUe4=;
        b=QJHjRJNINISBWhoD9qoS7Ds5ICl9yObcv4V2aLgbnoyIg5/MtRJxjgTJKw3QdELp0E
         6iNqyo6u+s4t4hyG4XCw30DN7LOcQRh9OMl8CYNIB6lUd/lszk3667ukTGE682b7wGS2
         OfH+s0GSegiYz4WEBO+6hFc66AqXfeJ8Z0l6hE5i1caMFyLHeWXqbL1Vv9iZNL9J30+l
         rNwfdubgDkWyIczFkRWTqeI3iCVbY+9ayZVANhvrRAnfWPSCTeVBKJR4YXB6Mgsim8wg
         2IUhR1NWmscS22lZuCPSWBnYeA5G4YjcpK+xrcOm18uO8xDb46/Od9rvVl2vM8nC48J1
         Pm6Q==
X-Received: by 10.129.91.87 with SMTP id p84mr19626535ywb.95.1437209279100;
 Sat, 18 Jul 2015 01:47:59 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 01:47:59 -0700 (PDT)
In-Reply-To: <1437171880-21590-18-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: gq4Wja37ySWjHjlT2eJzLs0HiE8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274160>

On Fri, Jul 17, 2015 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This gives a thin abstraction between the conflict ID that is a hash
> value obtained by inspecting the conflicts and the name of the
> directory under $GIT_DIR/rr-cache/, in which the previous resolution
> is recorded to be replayed.  The plan is to make sure that the
> presense of the directory does not imply the presense of a previous

s/presense/presence/g

> resolution and vice-versa, and later allow us to have more than one
> pair of <preimage, postimage> for a given conflict ID.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
