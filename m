From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/4] bisect: replace hardcoded "bad|good" by variables
Date: Tue, 9 Jun 2015 10:12:32 +0200
Message-ID: <CAP8UFD1mWaXwJwFLcw2f4Qj1v_Ves1UHEH7qkk8yq6WhjLeZGQ@mail.gmail.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqtwuhl6s0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git <git@vger.kernel.org>, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:12:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2EeF-0000NJ-WE
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 10:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbbFIIMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 04:12:36 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35934 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbbFIIMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 04:12:33 -0400
Received: by wigg3 with SMTP id g3so7924614wig.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UkDjnGEFZA4NBoLtuqmcnTPwITaE2woe1zSCpXgGiuk=;
        b=MA61pNQrI+NhJZvI9WXYUnbKcuJ6TltQ6Je+YDJCbjjjcoPjgKMecmd2DzJRUg9pqj
         ByWpZYeQ42imCSeDv9p60ZZN3FZggkWTVNJPLkkNXu7FI+T7sCQjq4qBTk5Ut1S/7vDF
         NhsKr0oXpZu/fUAVreAurDz2+EU9mxgAyt9e2R81fFRCiLIjV0zH9My5fc65l9ppK5i9
         ikMVp5tpvpmUrRWBYF8otPSslaMJh4V/VKrlfuVdts9ZSoPEJRwsP79kK8TJ2zGa4MJ5
         SWM0nFRX3JMrvKQpMPug1KTWftlfAY7QIUL8Cwr7Lj/vN7wdnJMDccIUtQjqbhRvDmi1
         bXTw==
X-Received: by 10.194.2.68 with SMTP id 4mr30694495wjs.82.1433837552524; Tue,
 09 Jun 2015 01:12:32 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 9 Jun 2015 01:12:32 -0700 (PDT)
In-Reply-To: <vpqtwuhl6s0.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271150>

On Tue, Jun 9, 2015 at 8:45 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:
>
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -32,6 +32,8 @@ OPTIONS_SPEC=
>>
>>  _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>> +NAME_BAD="bad"
>> +NAME_GOOD="good"
>
> I would have written
>
> NAME_NEW=bad
> NAME_OLD=good
>
> "old/new" are the generic wording, so I think it would make more sense
> for the codebase to use it when we don't hardcode old/new.

I don't agree with NAME_NEW and NAME_OLD instead of NAME_BAD and
NAME_OLD, for me it is easier when reasonning about the code to always
think as if we want to find a bug. This is especially true when
thinking about cases when we are given a "good" commit that is not an
ancestor of the "bad" commit (and we have to find the merge base and
so on), because in this case the "good" commit might be newer than the
"bad" commit.

"old/new" is not more generic than "good/bad". It just has a different
kind of drawbacks, and as "good/bad" is older and is the default we
should keep that in the names.
