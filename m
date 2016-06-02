From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Segfault in the attr stack
Date: Thu, 2 Jun 2016 08:04:25 +0700
Message-ID: <CACsJy8CCo1UC8KZNdap8K6_z1_kXOQ0qxhDEZusG62cAt4x_bQ@mail.gmail.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
 <CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com>
 <CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com> <CACsJy8A4gXRyx4LpBmM2Y=n2KB0NurKMiW42-tPnU7K89qj5bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 03:05:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8H4G-00009G-Ca
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 03:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbcFBBE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 21:04:56 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34759 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbcFBBE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 21:04:56 -0400
Received: by mail-io0-f177.google.com with SMTP id p194so33516464iod.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SATWCbNy7WU6e9m4adT5IEi4jQqrjBojIjAifrevV+E=;
        b=pfWq2f7iARbFZWnNKup7C4KLponsSVCtewyjFal/Rku4bjELh4P+zpqWL3GE4qtoMY
         3NQkvEUl3fNxtikdNBTyxiaKKHEmtKyUFAz4zDWqIB1uAYtvcwBY+HRlp5GZS6cmdvvN
         eH7KoxIzHFvtk3FKUJY6J6zZbSrsU4naSh9wNGKnpKPYu9FJ+7/NknsljzLf5x0AlRtR
         i9aCr4RRdDBEM4mu5d6sfd13ixOc3IttN+X5frldy8cDoxfXim/zBAN8FWcEwH78hnpv
         +l4A/yoV3lbI5LnK+2ONOXSyoirpzqzo9sJ6iFkrizn+SMJVYk0eJUAplzLUYztHvWYC
         2TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SATWCbNy7WU6e9m4adT5IEi4jQqrjBojIjAifrevV+E=;
        b=meY0Nc2ok/W76DFxLzgsjEcYN14Ag5AehNuG6tDJMs/GF1hDmpn41nf2rYntwNFL9D
         Ivi2Kbud5Qd4HujK+AvWfGr6IwqVVZq5YMrpqNJPUD8uUP3YAJ+MEji549O+DNmuI+LI
         OKSPAikjtoxqcwlcQKoT/cWIUMLn29S9uXVgTraNX/PmCKMDsuwweII5yTsI/ANrSoFT
         TrWgQuqkhdASjgDe6lzyFMbNsC6fbPVRG6S58Tz1fyviBPodkdfaAxN5FTxNsFg2Dgt+
         eavaUKLTA2mh5rJLeb4Oij7QUKL+6uzQnmL9lL0AfQezI0y6qC6fT3vsS8Lc+uVCUg6H
         HF4w==
X-Gm-Message-State: ALyK8tLCURj4HDzLdH706JlJxyv3ShRbCOpWeuJ8IhJ8ZFrrEVTxxh82IVwcWg18lAoCSHCMm6flNaiJwABxAw==
X-Received: by 10.107.22.131 with SMTP id 125mr535512iow.128.1464829495188;
 Wed, 01 Jun 2016 18:04:55 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 1 Jun 2016 18:04:25 -0700 (PDT)
In-Reply-To: <CACsJy8A4gXRyx4LpBmM2Y=n2KB0NurKMiW42-tPnU7K89qj5bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296183>

On Thu, Jun 2, 2016 at 8:02 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jun 2, 2016 at 5:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Gaah, of course.
>>
>> This is coming from the cache preload codepath, where multiple threads
>> try to run ce_path_match().
>> It used to be OK because pathspec magic never looked at attributes,
>> but now it does, and attribute system is not thread-safe.
>
> Off topic. I wonder if we can annotate which functions are thread-safe
> (minority currently in git code base, I believe) and make gcc, clang
> or sparse spot them in threaded code?

By them I mean unannotated (i.e. not thread-safe) functions, of course.
-- 
Duy
