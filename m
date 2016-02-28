From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/7] notes copy --stdin: split lines with string_list_split()
Date: Sun, 28 Feb 2016 11:02:38 -0500
Message-ID: <CAPig+cSOjdCkMAKEJ+7o=-cGsLgZWG5mnVmkWLSbyedg=mY5Lw@mail.gmail.com>
References: <56D28092.9090209@moritzneeb.de>
	<56D28207.6080600@moritzneeb.de>
	<CAPig+cT2GQ7mr0i649JRkJA7xGzXLEmy0RD31u537==sU1mtqQ@mail.gmail.com>
	<56D2A60A.4000306@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 17:02:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa3nw-0008Er-RD
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 17:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758018AbcB1QCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 11:02:40 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35960 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920AbcB1QCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 11:02:39 -0500
Received: by mail-vk0-f68.google.com with SMTP id k196so7898843vka.3
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 08:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0TCSIaAo1niU5GybOzn7bmJuV655hEc3bZhevbsAhHg=;
        b=Df3+maXx3rjgKuoCQdKaDcXYXAiPs5R9p/GPmNPQ3WhEUWqMLqAIG7/rAgCoDmQ1/Q
         lQiRkCqwF98psN76wW07lO162RjUohmQJ86duE4qhaJkEW1eoYZuaR2wct6co3Cdm/OV
         8EJY+YTse6Rxn/J1L4d20YlRFI7jIyPr6/+uWHiGYMEnpA0UA4/K0RFrQI3J1cLm46qr
         xoWQNzsPfXnvRpygCJ8zXAa+RFQua520gz6HfdkY0KFkDk3uG4qtAiwSqZF+hhmQhJZo
         XoqQNwtcJMJYFgKF0eL6NyOpp6WFBqqzmTtSIyNXAK/eC3b4mZP2fZhgitHXeg7G9Myh
         7idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0TCSIaAo1niU5GybOzn7bmJuV655hEc3bZhevbsAhHg=;
        b=IY/fNcGXmZyectmfb1fFXg2u0rTSOOJ+1s5meCutkZnY4u+QJz6kaE5wtCr6kMqooz
         ptuaxr+MRseHIiliH0y5Nn+N46HDEzxuXbj3hcCe60VShGMDJaaXinqh5DLShgHF4VqU
         L/HgV7jxYDPAp8IV3du7P0AobCfv/S+ZoRSabgKi2XoRG5xlNytUOqAMMdN0mcnhwbRA
         DvT6Pdf9h+SGHN+N5uOSUpJKUzH32amyAi5v/ZSJW+c8wZkPTQFgiwGAF1fU2j+kmxmf
         Jr1MxoUSD5zgiWRAplaYoZuJ/QLc0v16D+yKLQcPVxj0MS1My2aWn1+M1q22lLJ0W9Qb
         FXvw==
X-Gm-Message-State: AD7BkJLlZczAoEaB2mPu1mRf2F7wWjjR42j2oCmnoxNlXoadjeKyn0zsU9SUXAensDCEWCJ0CaiPDVXOe/oJcA==
X-Received: by 10.31.8.142 with SMTP id 136mr8474690vki.14.1456675358460; Sun,
 28 Feb 2016 08:02:38 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 28 Feb 2016 08:02:38 -0800 (PST)
In-Reply-To: <56D2A60A.4000306@moritzneeb.de>
X-Google-Sender-Auth: AoOdMZK5HHQ-qsaCz7Giqo2QgGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287775>

On Sun, Feb 28, 2016 at 2:47 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
> On 02/28/2016 07:56 AM, Eric Sunshine wrote:
>> On Sun, Feb 28, 2016 at 12:13 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
>>> The strbuf is now rtrimmed before splitting. This is still required
>>> to remove potential CRs. In the next step this will then be done
>>> implicitly by strbuf_readline(). Thus, this is a preparatory refactoring,
>>> towards a trim-free codepath.
>>
>> I would actually swap patches 4 and 5 so that strbuf_getline() is done
>> first (without removing any of the rtrim's) and string_list_split()
>> second. That way, you don't have to add that extra rtrim in one patch
>> and immediately remove it in the next. And, as a bonus, you can drop
>> the above paragraph altogether.
>
> Yeah, I also was thinking about that, should've pointed that out.
> I was just following your "guiding" in v2 [1], that's why I did it this way,
> because I thought it is somehow expected to be a prepraratory change.

Indeed, I meant to add a footnote acknowledging that and saying
something along the lines of: "Despite suggesting this as a
preparatory change in my v2 review, having now seen actually seen it,
it makes more sense as a follow-on change."

> Ok, when switching 4 and 5, I could call it something like "post cleanup/refactoring"
> instead.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/286868
