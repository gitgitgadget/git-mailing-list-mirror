From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 19:04:18 +0530
Message-ID: <CALkWK0nyNXsyzoTVz9vE5c5FP5k-KnPpzW2LryuCtmLP4WLXZA@mail.gmail.com>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com> <20130614131629.GA1086@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:35:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnU9i-0006es-Hf
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab3FNNfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:35:00 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36828 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab3FNNe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:34:59 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so1443281iea.18
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WTbv3AFqBDfvw6XNsmhocMdtbgv5kvPjEIanbsM8PCI=;
        b=meJytuLTwN1FfdNxS2v4bxvMcr5RgZ6N7wdrvC/JN6v23X3zn6bl65HS9fJzYMukB8
         trqHQiUzCSz1j5U2pW8sr8fwyxBHaq/G8WjRWPvyDyCrVHHLicyASgJeIhFPlEl5RAep
         HV8XUwFBShZgWS5YAv46+wYN99t4DS5Uq7PeoE5xmoQNEDQyQyQxTeSmBAjIhU4Hq7oQ
         SM+F+Nzx2qz5aWAfh1MRRD5zcSyThY+VKxbHrOm9TDSNnofGT1c3jCZV5mruZPgElOfl
         y0oyHsarBHDEzhNvGja+JMLtm+rkzx8WO1g3x9RFLAmBDDhU/WUUmOCkVzjjLS2vDnG7
         J+vw==
X-Received: by 10.50.98.104 with SMTP id eh8mr1054248igb.111.1371216898234;
 Fri, 14 Jun 2013 06:34:58 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 06:34:18 -0700 (PDT)
In-Reply-To: <20130614131629.GA1086@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227831>

Fredrik Gustafsson wrote:
> However I think this patch can improve the workflow for experienced
> developers. Can we tweak this in some way to get the best out of both
> worlds?

The main problem is that output-directory can be an absolute path
(like ~, in the extreme case).  I'm not sure how to trade-off safety
for speed.  My main itch is that completion doesn't work with my fp:

  alias.fp = !rm -rf outgoing && git format-patch -M -C -o outgoing

>> +             struct strbuf buf = STRBUF_INIT;
>> +
>>               if (use_stdout)
>>                       die(_("standard output, or directory, which one?"));
>> +             strbuf_addstr(&buf, output_directory);
>> +             remove_dir_recursively(&buf, 0);
>
> Should we have a strbuf_release here?

Yeah, my stupidity.
