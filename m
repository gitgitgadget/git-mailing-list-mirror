From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 0/3] prepare_packed_git(): find more garbage
Date: Mon, 11 Jan 2016 08:35:00 -0800
Message-ID: <CAGZ79kZ=OSGVu5w7ZjZHhUKggSStp2ihV5iW2oawTYLG5htj7Q@mail.gmail.com>
References: <20151215232534.GA30998@sigill.intra.peff.net>
	<1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
	<20151219020247.GA3098@sigill.intra.peff.net>
	<20151219020324.GA3118@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Doug Kelly <dougk.ff7@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 17:35:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIfRR-0002cV-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 17:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053AbcAKQf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 11:35:27 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33167 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933972AbcAKQfB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 11:35:01 -0500
Received: by mail-ig0-f170.google.com with SMTP id z14so122637330igp.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 08:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jyTRqqdw9/aOuW7TOvN+VSo6ts3lIcrDSefsk1OKLMk=;
        b=bwhnOdHehBBwzNSCpJukNV7PB+HqykfVM2c1ms2Gp3NAHzyMxdNdAif4DTXvuEeA39
         OkLylVZhzJXWvrffQuzQ9/jFJFfGbWBZ+YYGKPfIa3I4hCbsFsgt4/dWX/Bl36wkM3KR
         QKuvygLRrB3ltCpSlnzXIpeS9A8n1EUAfTKMFhKtcqqyZqu2mwuc33JmUMJFOCzbRDrt
         zECRoyTWw1uxfou5btjYr9YJHWTbJKHL2HSD9P/pCfKSoCGaVSvgGNpFW2XxUybk77dn
         uN4UKEiozHh+e6cpX5n5WeFBtyhPpDVMA6sNamoR4LUzAcZHLZUjg1FO8qGTsinMJ2aD
         uJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jyTRqqdw9/aOuW7TOvN+VSo6ts3lIcrDSefsk1OKLMk=;
        b=M7VwcPPZ7j1TgGCGXJgReEcjsYz4FYz/RYuLRuVgiQb3sRzZT3RX3aDOVMs4XCbCfn
         QqUEagOJVCkrhMlnx786uZyvxPnV/OYS0UCnhgLRYM4sKr1HG0XwZE46hDbdXLDGjFr9
         DkyatWk+ghnDnpyMP9Sg6LyXJIDzQ1hK/0yjgJRVAq+x5xOeQxvM3kZVIKSG+7Pc7i1f
         NEk0nqWL8Oy5g0ysTAvhTrL1T9JraQz/kiNeg1o23ELvrix+xpokakQRq3CFITzKpC7R
         ToEAsJeVjVCfKEEqQqRzKdgi5b6pZZAl7cOslHNE1w4nUIn+oC3JcODBNpAjLgWbOun0
         GPjA==
X-Gm-Message-State: ALoCoQlQePMjGHwGq4JL3h63g1X2c+4qkL8OE81Eul4518J/jEblz6zL8SQvNimcIfrqeVVYIeJpo1KYvQ4M3XkAlwtHirAwBr+/nvqP1qXkcfQ4aURfhOE=
X-Received: by 10.50.77.81 with SMTP id q17mr8000180igw.93.1452530100126; Mon,
 11 Jan 2016 08:35:00 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Mon, 11 Jan 2016 08:35:00 -0800 (PST)
In-Reply-To: <20151219020324.GA3118@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283667>

On Fri, Dec 18, 2015 at 6:03 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 18, 2015 at 09:02:47PM -0500, Jeff King wrote:
>
>> I left a few comments on 3/3. I don't think it's _wrong_, but I think we
>> can be a bit more thorough (and IMHO, a little more maintainable, but
>> others might disagree).
>
> Oh, and I forgot to say thank you for working on this. :)

Thanks for working on this from me, too!
[PATCH 1/3] prepare_packed_git(): find more garbage looks good to me.


>
> -Peff
