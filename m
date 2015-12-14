From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Mon, 14 Dec 2015 20:58:06 +0000
Message-ID: <CAE5ih7_9m8kw=sVj8Sv5mAfT_22-g0vdTb78FvLTrNUkJO0M0g@mail.gmail.com>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
	<CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com>
	<xmqqio40kfhl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sam Hocevar <sam@hocevar.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:58:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aCD-0003D3-Qs
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbbLNU6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:58:09 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38064 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbbLNU6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:58:07 -0500
Received: by igbxm8 with SMTP id xm8so93862938igb.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N6Go2wWQIRns4iDR+9vPjSUxgIbmhEKJ84DMcId+9qE=;
        b=GSMLyfKVabsaSkmgiehq2jQJWktIqfeC0/WTsE4tdu00QLAy7Md7wkrAbfa32cFi8Q
         SHhmC1BTYT1MHTQlgbIpc8dkVEskPnexbmlEa6qzr7VltWaOIpzQ6807dHJBKe2hhrjz
         6oxuSg10SY8DldfLju09cm5RfHzUMt0jaEsn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N6Go2wWQIRns4iDR+9vPjSUxgIbmhEKJ84DMcId+9qE=;
        b=QHX1/LtsQi02vKW6eHND912iqAcNdFINnwdhQY1lgPtLETy5ERn3Eetm/0VoZYLnXF
         pamgUGUwcFnRXEMtRmp23uSIdaCEIbs6rJZfnY/aH++e/TjXVUQ62Ib8jPFhcJk3n7cr
         ViTHwa5Hs+OKwvX8HCoRunmL0uEsXp8XMHzMATkAXUHYVT9gaHfcA9DmkSvYsqCcCzfZ
         aynENd+aFStPJ10mb38WatCsDqR01pvZPB+I4Cd0wRsUkZwMDHbAu17691AwNOaW7V34
         UfYEm9sC/ykXwOKdL7IBMYtlvF5MPF7k5fZq41b9x+yltfr2WOtmn06KqIHPA1cA0dbi
         QaLg==
X-Gm-Message-State: ALoCoQlAlNHr+juxNqyeczcAgtnC00sJlHg6SDkw8gl05tU8wrKRXqDGqLVbqP5RnE7njHoMQDQSVqYoRybqDrL7iA9XQ6bPAA==
X-Received: by 10.50.153.69 with SMTP id ve5mr238613igb.80.1450126686466; Mon,
 14 Dec 2015 12:58:06 -0800 (PST)
Received: by 10.79.94.194 with HTTP; Mon, 14 Dec 2015 12:58:06 -0800 (PST)
In-Reply-To: <xmqqio40kfhl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282411>

On 14 December 2015 at 19:16, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> Having just fixed this, I've now just spotted that Sam Hocevar's fix
>> to reduce the number of P4 transactions also fixes it:
>>
>> https://www.mail-archive.com/git%40vger.kernel.org/msg81880.html
>>
>> That seems like a cleaner fix.
>
> Hmm, do you mean I should ignore this series and take the other one,
> take only 1/2 from this for tests and then both patches in the other
> one, or something else?

The second of those (take only 1/2 from this for tests, and then both
from the other) seems like the way to go.

Thanks,
Luke
