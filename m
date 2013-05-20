From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 16/17] object_array_entry: copy name before storing in name
 field
Date: Mon, 20 May 2013 23:34:13 +0200
Message-ID: <519A96D5.2070608@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu> <1368995232-11042-17-git-send-email-mhagger@alum.mit.edu> <CALKQrgeZ3yOogZhumQ6sQ=7B4XoEUDxPNt6Lj7ZAs13oJTOeUA@mail.gmail.com> <519A365E.6020807@alum.mit.edu> <20130520164458.GA27788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 20 23:34:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeXip-00060P-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 23:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab3ETVeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 17:34:19 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:59431 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756561Ab3ETVeS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 17:34:18 -0400
X-AuditID: 1207440d-b7fd06d000000905-54-519a96d98786
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F6.4C.02309.9D69A915; Mon, 20 May 2013 17:34:17 -0400 (EDT)
Received: from [192.168.69.140] (p57A25AF2.dip0.t-ipconnect.de [87.162.90.242])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4KLYEpd024588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 May 2013 17:34:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130520164458.GA27788@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqHtz2qxAg0nNihZdV7qZLBp6rzBb
	zLu7i8niR0sPswOLx6WX39k8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujJ2zbrMX
	rBWvOPvqBWMD42mhLkYODgkBE4lrD7S7GDmBTDGJC/fWs3UxcnEICVxmlNi8+gc7hHOeSeLV
	sjdsIFW8AtoSa5YvYAGxWQRUJU7ebmMEsdkEdCUW9TQzgdiiAmES75dNZYWoF5Q4OfMJWL2I
	gKzE98MbweqZBdIlXs84wQZyhLBAqMS8w8IQuyYxSUxsOAJWzylgLfG66ycjSA2zgLrE+nlC
	EK3yEtvfzmGewCgwC8mGWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6SXm1mi
	l5pSuokREsq8Oxj/r5M5xCjAwajEwytoOCtQiDWxrLgy9xCjJAeTkijv5X6gEF9SfkplRmJx
	RnxRaU5q8SFGCQ5mJRHe781AOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwM
	B4eSBC8TMGaFBItS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFRGl8MjFOQFA/Q3t9T
	QfYWFyTmAkUhWk8xGnNsPj/5HSPHjB9AUoglLz8vVUqcVwFkkwBIaUZpHtwiWBJ7xSgO9Lcw
	Lw9IFQ8wAcLNewW0iglo1XbLmSCrShIRUlINjLwX/lVKq0ffYr19pGv+3VbR/cG9D2/HvKya
	vH6C8tHjVT97uXO3LFhbO33Cv8VsNw5Kiz7YqWl39lDz58e2D158Dtxy9PTlh01r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224984>

On 05/20/2013 06:44 PM, Jeff King wrote:
> On Mon, May 20, 2013 at 04:42:38PM +0200, Michael Haggerty wrote:
> 
>>>> * Many callers store the empty string ("") as the name; for example,
>>>>   most of the entries created during a run of rev-list have "" as
>>>>   their name.  This means that lots of needless copies of "" are being
>>>>   made.  I think that the best solution to this problem would be to
>>>>   store NULL rather than "" for such entries, but I haven't figured
>>>>   out all of the places where the name is used.
>>>
>>> Use strbufs?
>>>
>>> No allocation (except for the strbuf object itself) is needed for
>>> empty strings, and string ownership and be transferred to and from it
>>> to prevent extra copies.
>>
>> That would cost two extra size_t per object_array_entry.  I have the
>> feeling that this structure is used often enough that the extra overhead
>> would be a disadvantage, but I'm not sure.
>>
>> The obvious alternative would be to teach users to deal with NULL and
>> either add another constructor alternative that transfers string
>> ownership or *always* transfer string ownership and change the callers
>> to call xstrdup() if they don't already own the name string.  I think I
>> will try that approach first.
> 
> You could use the same trick that strbuf does: instead of NULL, point to
> a well-known empty string literal. Readers do not have to care about
> this optimization at all; only writers need to recognize the well-known
> pointer value. And since we do not update in place but only eventually
> free, it really is just that anyone calling free() would do "if (name !=
> well_known_empty_string)".

Yes, that sounds like the best solution.  Ultimately there is only one
writer, add_object_array_with_mode(), and it can do

    if (!name)
        entry->name = NULL;
    else if (!*name)
        entry->name = well_known_empty_string;
    else
        entry->name = xstrdup(name);

This should be a lot less intrusive than what I was trying: to change
callers who wrote name="" to write name=NULL instead.  But it is a
nightmare to find all of the code that reads name and decide whether
they need to do

    entry->name ? entry->name : ""

because that in turn depends on whether the code that wrote into the
same object_array always/never/sometimes wrote strings vs. NULL to the
name field.  Blech, encapsulation is tough in C.

While I was chasing down callers, I came across other gems like

builtin/checkout.c:
	add_pending_object(&revs, object, sha1_to_hex(object->sha1));

revision.c:
	add_pending_object(revs, object, sha1_to_hex(object->sha1));

submodule.c:
	add_pending_object(rev, &list->item->object,
		sha1_to_hex(list->item->object.sha1));

so apparently I wasn't the only one befuddled by the lifetime and
ownership of the name field of object_array_entry.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
