From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 12:05:50 -0700
Message-ID: <CA+P7+xrSAo43=-3q-7SPxerYPKU3+T75dG5dTE=H8odicRDxSg@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
 <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
 <CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com> <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:06:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbLu-0005Qm-US
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbbHLTGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:06:12 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38393 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbHLTGK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:06:10 -0400
Received: by igfj19 with SMTP id j19so20647323igf.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bTAZ85Bruv0bQL2IaTBHdqfizsJUipXfq1eI2qr9vBQ=;
        b=kvrEhCiYDFuCF/T0TfX5Y5vYJn3U6OVd7vUF0qiAccr4OggmJ035JLvFr7gZzlYNOI
         hPAxUFswKHA9G622jXVAE/1jm0OACJC2HolQXqtm8Tz2stAwpO4dsGlIkXZqbcmEMciO
         WgN42nEFyTRhmyKiKghivM7a7LCjFj3FclEl6brwWAIaanqsW894cyW35sahYVzLrwlK
         Vn93P3cPawnxfPL1tUwjJV2kTMMCO/Ye1FtKFkRVib4vxxKbE+G6ETnUJV7XszHZC+Yg
         B1zjFqcd2SVabZeYmZxBzGd7ZT5KGxGMvruGjtzuJXriMN2PiH5flh7CjcLaHUZsPHP8
         Xb/A==
X-Received: by 10.50.72.113 with SMTP id c17mr23982187igv.73.1439406369912;
 Wed, 12 Aug 2015 12:06:09 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 12 Aug 2015 12:05:50 -0700 (PDT)
In-Reply-To: <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275797>

On Tue, Aug 11, 2015 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> I know that we don't yet have a "proper" place to put remote notes refs,
>> but the <ref> in notes.<ref>.merge _must_ be a "local" notes ref (you even
>> use the <localref> notation in the documentation below). Thus, I believe
>> we can presume that the local notes ref must live under refs/notes/*,
>> and hence drop the "refs/notes/" prefix from the config key (just like
>> branch.<name>.* can presume that <name> lives under refs/heads/*).
>
> I am OK going in that direction, as long as we promise that "notes
> merge" will forever refuse to work on --notes=$ref where $ref does
> not begin with refs/notes/.
>

It appears that notes merge already allows operating on refs not in "refs/notes"

the way you select what you are merging into is via either --ref or
the environment variable.I chose to use the full refs/notes/* format
as it was the only one that also supported all layouts.

So, should we enforce that default_notes_ref always requires refs
inside refs/notes? that doesn't seem a bad idea here.

If we only disallow it for merge I think that would be very confusing.

Regards,
Jake
