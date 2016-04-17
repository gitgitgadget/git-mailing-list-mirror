From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/6] tag: move PGP verification code to tag.c
Date: Sun, 17 Apr 2016 14:14:33 -0400
Message-ID: <CAPig+cR+6-sDK7kFP0y7OeYCPUQWZ7wWeaJtzF_ee3DVoymvNQ@mail.gmail.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<CAPig+cQ4n5j4Q-WF-0cd=2+5eSAaimh3A7La+8Fe9Ox4anjtBQ@mail.gmail.com>
	<20160407034007.GC17848@LykOS>
	<CAPig+cQxmovGckrbwuEoeA=hW1idukj3qKTfjmr8B+AM7E2J0A@mail.gmail.com>
	<20160417173406.GB1014@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:14:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arrDT-0000K2-Je
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 20:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbcDQSOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 14:14:35 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35425 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcDQSOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 14:14:34 -0400
Received: by mail-ig0-f196.google.com with SMTP id fn8so8516191igb.2
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=DfEF6FbXE8nqmuo9qqdDehpsffQF0JvVad0BhUce66o=;
        b=apEqIfbf/LxlYi7gNKjw1lJfcwIfMPMAhhrNlM6u+ajd/aguZTgGc590XV7BfkmrCc
         iNcIvUXJW25Qq5DYY7QMY3Z4zjOJ0uaB8LE8LVBoUMYJYL6UIVNE+t8O94qy1W9IWQ0w
         dIISg2rc4ItX+OySjmSWOPw2b9ojW+6HAMUenJcPmeEEImrpbZGRmPQH5pht45RHGuh0
         h8iooixACvZ6TsXUmEo1uZ4xnHVvoiW5anNMkyl4joClHVgn9pkbmPHMn4BeVTgh52Qf
         xmM0/XlCvexbJet7beOnY0gDpw19KxNkCrnN1bq3AZy0EAnsE1jRvg5CTKGemYOhcSDq
         2lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DfEF6FbXE8nqmuo9qqdDehpsffQF0JvVad0BhUce66o=;
        b=ce9ypo8kJN5Uju9LqscJ9uBlprxWwY8DRSRijyQzEMVF7cRHqGG8Sn8Fc9lARhsWEG
         s7cFMnxwVeFh8EesxPYAs2AenfNCEanmoAptuJZc0k2Go2CZszaj8Qd8jEtrqM/bRKpW
         markpxIbVdN7enjSWvVOqrhSzN7ReN9GEzmdL/VdIJrpLTRA2qcF1NMnzkbjhvM0hCDm
         ZG709BfVsYqh53KjOYDSpCgQCtrrFTlD9o6pkJCZkqWcTy4/0Nq1kFskA4EjOElHvZca
         Q9UpHwo6bA8NUJ0rQ08TP01wBZ/zJHv186JVnsIaCNMv1qtPPPyF9qfjLjiyi0i/KqxP
         LHKA==
X-Gm-Message-State: AOPr4FXgoHuHmzWuxM2dLYe+eTk3U9lVoZD4RafOyxRvE7cJvjOAR8tJtv1miR9PlJEwBxnirr6356h55HhUnA==
X-Received: by 10.50.142.2 with SMTP id rs2mr14675779igb.72.1460916873657;
 Sun, 17 Apr 2016 11:14:33 -0700 (PDT)
Received: by 10.79.16.67 with HTTP; Sun, 17 Apr 2016 11:14:33 -0700 (PDT)
In-Reply-To: <20160417173406.GB1014@LykOS>
X-Google-Sender-Auth: J8WVhbAxk87LHvKppSVTYlpbKZ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291768>

On Sun, Apr 17, 2016 at 1:34 PM, Santiago Torres <santiago@nyu.edu> wrote:
> On Thu, Apr 07, 2016 at 12:19:37PM -0400, Eric Sunshine wrote:
>> If you make any changes beyond the minor ones mentioned in my reviews
>> or beyond plagiarizing commit message enhancements offered by my or
>> Junio's reviews, then you'd also probably want to hold off adding my
>> Reviewed-by: since I wouldn't yet have reviewed whatever new changes
>> you're making.
>
> Speaking of which, would it make sense to add "helped-by" to the patches
> in which I'm plagiarizing the commit messages?

Yes, that would be quite sensible.
