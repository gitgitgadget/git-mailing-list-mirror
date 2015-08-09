From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sun, 9 Aug 2015 12:25:52 +0530
Message-ID: <CAOLa=ZQW1HBACAb4V_jMky4=54=rxqS=nyYMBX1CUUvA2c0s9A@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
 <1438800854-19901-1-git-send-email-Karthik.188@gmail.com> <CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
 <CAOLa=ZSkmkPpiEfDrRXNQ6Tz5GT1+7vef3TOrj1t9aZ_3wm2Lw@mail.gmail.com> <CAPig+cTHKbn0oCV61n=p5o9WihsaJbvWqKt4y9eFwA0noJoPgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 08:56:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOKWy-0005tB-Cn
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 08:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbbHIG4Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2015 02:56:24 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35833 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbbHIG4X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2015 02:56:23 -0400
Received: by oihn130 with SMTP id n130so74692001oih.2
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=df8jmVKYrI8ylP4aSLuHgIBctG0a4zPOr4wBnx1iO98=;
        b=rh52rF555t2fuo3+XAYvGFWByVaNcPuOQ7Y2nhHyzY4zkWoRdRgbUhk3Pcpdv6ylRP
         Ed9sVQZgSzS0fsOLoemSRckgMjV0G/yUUR3mRlWfmra+nobGszfi0V0kwAp5pUahoS53
         SmTWc2iF6RlFGx5DObAt0CQB+khlxOyAIIEhlKoxtjI3LoWlx3If2MPWZnpUEqDPG/dp
         Hb+H+8guI37im22FlaFTqRYzm2l36xCDQf/mTe1sXudqbdOzkjiFL2h9/MhvXN7hS5CF
         hwSnry3wrJVmUnW4xIg/h/BxgfMAPfyGMM9vYKwEALGEDF+Zc4O4RX9wuCu0Nk54plke
         Houg==
X-Received: by 10.202.200.75 with SMTP id y72mr13762878oif.111.1439103382296;
 Sat, 08 Aug 2015 23:56:22 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 8 Aug 2015 23:55:52 -0700 (PDT)
In-Reply-To: <CAPig+cTHKbn0oCV61n=p5o9WihsaJbvWqKt4y9eFwA0noJoPgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275527>

On Sun, Aug 9, 2015 at 9:12 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sat, Aug 8, 2015 at 2:35 AM, Karthik Nayak <karthik.188@gmail.com>=
 wrote:
>> On Fri, Aug 7, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>>> On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>>>> of the padding to be performed. If the atom length is more than th=
e
>>>> padding length then no padding is performed. e.g. to pad a succeed=
ing
>>>> atom to the middle with a total padding size of 40 we can do a
>>>
>>> It's odd to have alignment described in terms of "padding" and
>>> "padding length", especially in the case of "center" alignment. It
>>> might be better to rephrase the discussion in terms of field width =
or
>>> such.
>>>
>>>> --format=3D"%(align:middle,40).."
>>
>> Ok this makes sense,
>> I'll rephrase as :
>>
>> `<width>` is the total length of the content with alignment.
>
> This doesn't really make sense. <width> isn't the content length; it'=
s
> the size of the area into which the content will be placed.
>

Will change this.

>> If the atom length is more than the width then no alignment is perfo=
rmed.
>
> What "atom"? I think you mean the content between %(align:) and %(end=
)
> rather than "atom". The description might be clearer if you actually
> say "content between %(align:) and %(end)" to indicate specifically
> what is being aligned.

Yes, that's what I meant.

>
>> e.g. to align a succeeding atom to the middle with a total width of =
40
>> we can do:
>> --format=3D"%(align:middle,40).."
>>>> @@ -687,6 +690,29 @@ static void populate_value(struct ref_array_i=
tem *ref)
>>>>                         else
>>>>                                 v->s =3D " ";
>>>>                         continue;
>>>> +               } else if (starts_with(name, "align:")) {
>>>> +                       const char *valp =3D NULL;
>>>
>>> Unnecessary NULL assignment.
>>
>> Thats required for the second skip_prefix and so on.
>> Else we get: "warning: =E2=80=98valp=E2=80=99 may be used uninitiali=
zed in this
>> function [-Wmaybe-uninitialized]"
>
> Okay, so that's because skip_prefix() is inline, and it doesn't touch
> its "out" argument unless it actually skips the prefix. Ugly, but
> makes sense, although I think this issue would go away if you combine=
d
> the starts_with() and skips_prefix() as suggested earlier.
>

Okay then I'll declare valp prehand to get rid of this and also to
remove redundant, starts_with() and skip_prefix().

>>>> +                       struct align *align =3D xmalloc(sizeof(str=
uct align));
>>>> +
>>>> +                       skip_prefix(name, "align:", &valp);
>>>
>>> You could simplify the code by combining this skip_prefix() with th=
e
>>> earlier starts_with() in the conditional:
>>>
>>>     } else if (skip_prefix(name, "align:", &valp)) {
>>>         struct align *align =3D xmalloc(sizeof(struct align));
>>>         ...
>>
>> That would require valp to be previously defined. Hence the split.
>
> Yes, it would require declaring 'valp' earlier, but that seems a
> reasonable tradeoff for cleaner, simpler, less redundant code.
>

Yes. will do this.

>>>>  static void apply_formatting_state(struct ref_formatting_state *s=
tate, struct strbuf *final)
>>>>  {
>>>> -       /* More formatting options to be evetually added */
>>>> +       if (state->align && state->end) {
>>>> +               struct strbuf *value =3D state->output;
>>>> +               int len =3D 0, buf_len =3D value->len;
>>>> +               struct align *align =3D state->align;
>>>> +
>>>> +               if (!value->buf)
>>>> +                       return;
>>>> +               if (!is_utf8(value->buf)) {
>>>> +                       len =3D value->len - utf8_strwidth(value->=
buf);
>>>
>>> What is this doing, exactly? If the string is *not* utf-8, then you=
're
>>> asking it for its utf-8 width. Am I reading that correctly?
>>>
>>> Also, what is 'len' supposed to represent? I guess you want it to b=
e
>>> the difference between the byte length and the display length, but =
the
>>> name 'len' doesn't convey that at all, nor does it help the reader
>>> understand the code below where you do the actual formatting.
>>>
>>> In fact, if I'm reading this correctly, then 'len' is always zero i=
n
>>> your tests (because the tests never trigger this conditional), so t=
his
>>> functionality is never being exercised.
>>
>> There shouldn't be a "!" there, will change.
>> I guess 'utf8_compensation' would be a better name.
>
> Definitely better than 'len'.
>
>>>> +               else if (align->align_type =3D=3D ALIGN_MIDDLE) {
>>>> +                       int right =3D (align->align_value - buf_le=
n)/2;
>>>> +                       strbuf_addf(final, "%*s%-*s", align->align=
_value - right + len,
>>>> +                                   value->buf, right, "");
>>>
>>> An aesthetic aside: When (align_value - buf_len) is an odd number,
>>> this implementation favors placing more whitespace to the left of t=
he
>>> string, and less to the right. In practice, this often tends to loo=
k a
>>> bit more awkward than the inverse of placing more whitespace to the
>>> right, and less to the left (but that again is subjective).
>>
>> I know that, maybe we could add an additional padding to even out th=
e value
>> given?
>
> I don't understand your question. I was merely suggesting (purely
> subjectively), for the "odd length" case, putting the extra space
> after the centered text rather than before it. For instance:
>
>     int left =3D (align->align_value - buf_len) / 2;
>     strbuf_addf(final, "%*s%-*s", left, "",
>         align->align_value - left + len, value->buf);
>
> or any similar variation which would give the same result.
>

I get this could be done, what I was asking was, Consider given a align=
ment
width of 25 would be better to make that 26 so that we have even paddin=
g on
both sides. But I don't like the adding of manipulating user given data=
=2E

>>> This is a tangent, but I could easily see all of the code from 'if
>>> (align->align_value < buf_len)' down to this point being placed in
>>> utf8.c as a general alignment utility function. Doing so would make
>>> this function shorter, and the patch easier to review overall (whic=
h
>>> might be an important consideration -- especially given that I've
>>> already spent several hours reviewing this one patch).
>>
>> That's a valid suggestion, will do that, thanks, but that'd mean we =
need to
>> send an align struct to utf8.c which is only defined in ref-filter.h=
=2E
>> Either this
>> is fine or we need to move the definition of struct align to utf8.h.
>> I think personally move the align structure and enum over to utf8.h
>
> No, you don't need to move the 'struct align' to utf8.h. That
> structure is specific to ref-filter and should stay there. Instead,
> you only need to move the enum. For instance, you'd add something lik=
e
> this to utf8.h:
>
>     enum utf8_alignment {
>         ALIGN_LEFT,
>         ALIGN_MIDDLE,
>         ALIGN_RIGHT
>     };
>
>     void strbuf_utf8_align(struct strbuf *buf,
>         utf8_alignment where, int width, const char *s);
>

Okay will do this.

> By the way, I forgot to say earlier that this should be done as a
> separate patch (in order to make the current patch smaller).
>

Of course, that was obvious :)

> That raises another question. Why are 'struct ref_formatting_state',
> 'struct align', 'struct atom_value', etc. defined in ref-filter.h at
> all? Aren't those private implementation details of ref-filter.c, or
> do you expect other code to be using them?
>

I guess struct ref_formatting_state and struct align could be moved to
ref-filter.c. About struct atom_value its referenced by ref_array_item(=
)
so any reader reading about this, would find it easier if atom_value()
is at the same place.

>>>>         for (i =3D 0; i < final_buf.len; i++)
>>>>                 printf("%c", final_buf.buf[i]);
>>>>         putchar('\n');
>>>> diff --git a/ref-filter.h b/ref-filter.h
>>>> index 9e6c2d4..5575fe9 100644
>>>> --- a/ref-filter.h
>>>> +++ b/ref-filter.h
>>>> @@ -16,14 +16,30 @@
>>>>  struct ref_formatting_state {
>>>> -       int quote_style;
>>>>         struct strbuf *output;
>>>> +       struct align *align;
>>>> +       int quote_style;
>>>
>>> Perhaps decide where you'd like 'quote_style' to reside from the st=
art
>>> so that you don't have to add it at one location in its introductor=
y
>>> patch and then move it in a later patch. Also, why move it here?
>>
>> Cause that'd save memory on a 64 bit processor, where the pointers w=
ould
>> be 8 bytes long and int would be 4 bytes long, this would bring in p=
adding if
>> int is placed before the pointers. Will change before hand.
>
> As I understand it, you're not likely to have many
> ref_fomratting_state's around at any given time, so this sounds like
> premature memory micro-optimization.

Agreed, its a micro-optimization, but why leave it out when we only nee=
d
to re-structure code? I'll probably change it beforehand.

--=20
Regards,
Karthik Nayak
