From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 09/11] branch.c: use 'ref-filter' data structures
Date: Wed, 29 Jul 2015 02:08:03 +0530
Message-ID: <CAOLa=ZSD-sz5Ed9xGqORo5teBuqzSKSeZS-2n06RsuGSZKUa4A@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
 <CAP8UFD3L4QEYQMCda7AbByXGZcvgy5r9y0LMBqEysb6AZ+ydOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:38:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBe2-00076O-8V
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbbG1Uie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:38:34 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34284 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbG1Uid (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:38:33 -0400
Received: by obre1 with SMTP id e1so93739904obr.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9ArMHtDUqhe7AWS1bY6cFyqLg9nvNaB0+SOOhhTSUvs=;
        b=dsDUb7qpDQrMHojt3H8BdtYTGx6nz/m/sgXMviOntNo8Tfk2Ii6DxQATEfZOyiL4LU
         nVQINa/7HWsNy1qiQVYQVB8J7dovjqmvnCyf9QOeVitSAa6lhPhXRoJMyhjjJf153P7f
         /h8IYmPbhUbS9RKHlckfgZ0fuwF/93bM9mCVzI5IMkyYv9YBNxt6E35ybDb5XFJpTg+F
         2zxmGf5ldy1M9zA0YIrpF7bOOgnksD2P5DlfVh+Amei9F5ljNvm8vrDrno9+TVUbn0y/
         6l5QHNN/jb6S+R1lIa/aFKBA5kEbPZ5hK90sLlXVmwYu0FEevS1VwhocWGvFERVErOZT
         Rmhw==
X-Received: by 10.182.29.68 with SMTP id i4mr35596007obh.57.1438115912868;
 Tue, 28 Jul 2015 13:38:32 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 13:38:03 -0700 (PDT)
In-Reply-To: <CAP8UFD3L4QEYQMCda7AbByXGZcvgy5r9y0LMBqEysb6AZ+ydOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274841>

On Tue, Jul 28, 2015 at 1:47 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
>> +static void ref_array_append(struct ref_array *array, const char *refname)
>> +{
>> +       size_t len = strlen(refname);
>> +       struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
>> +       memcpy(ref->refname, refname, len);
>> +       ref->refname[len] = '\0';
>> +       REALLOC_ARRAY(array->items, array->nr + 1);
>> +       array->items[array->nr++] = ref;
>> +}
>
> This function belongs more to ref-filter.{c,h}...
>

Its a temporary function which is removed in the next patch.

>
>> -       ALLOC_GROW(ref_list->list, ref_list->index + 1, ref_list->alloc);
>> +       ref_array_append(array, refname);
>> +       item = array->items[array->nr - 1];
>
> ...and the above is a bit ugly.

Will fix that :)

-- 
Regards,
Karthik Nayak
