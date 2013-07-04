From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 16:40:51 +0200
Message-ID: <CANQwDwd9siyeu5xqS5Un+=8ioEaDbpT30vBpgJCVNUEcszcv1g@mail.gmail.com>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com>
 <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com> <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Jul 04 16:41:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uukii-0003BL-Cn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 16:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247Ab3GDOlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 10:41:12 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55246 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab3GDOlM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 10:41:12 -0400
Received: by mail-qa0-f46.google.com with SMTP id ih17so4279695qab.12
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6RAWWX0vZluoVedvvy8rFuLGgL+quovR/didkUos5Ss=;
        b=B+/iHPgRboIk6gsoniOHke05mHYq8Uwr5O4pTeIFhpqhqzPN0VO52pCoHYb93HhVNR
         f9l1C051iXlPAlfObiw6PwUb6IYjKJOisU0V4bl62j5ZNyqbU+ULhMj+gFzTDLjEugGv
         Tc4DOhtxe1go1wWH6XyvqumTZfvQgEDh2BDZIJIl9uTqwouaI9mPDb39YMYlVVbP0GFf
         Utn5hWJqgG4SfViTuaBYUr6cnczHxEW+Z2SFWdqY4MyZvBe8xrwgiUBq1bIyLROPODSd
         n6k76WRQ67lyU0kTssA+uUTgk+r67MP8viAsctQ/BoyjwDnUtU9/RMkPfBvbyHrw3SAg
         15Cg==
X-Received: by 10.49.127.4 with SMTP id nc4mr5115102qeb.41.1372948871244; Thu,
 04 Jul 2013 07:41:11 -0700 (PDT)
Received: by 10.49.75.169 with HTTP; Thu, 4 Jul 2013 07:40:51 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229591>

On Thu, Jul 4, 2013 at 10:44 AM, Tony Finch <dot@dotat.at> wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>> On Wed, Jul 3, 2013 at 11:59 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>>> Tony Finch wrote:
>>
>>>> +@extra_breadcrumbs::

BTW. perhaps (it is only an idea) @top_level_breadcrumbs or
@home_breadcrumbs would be a better name for this variable.

>>>> +     Additional links to be added to the start of the breadcrumb =
trail,
>>>> +     that are logically "above" the gitweb projects list. For exa=
mple,
>>>> +     links to the organization and department which host the gitw=
eb
>>>> +     server. Each element of the list is a reference to an array,
>>>> +     in which element 0 is the link text and element 1 is the
>>>> +     target URL.
>>>
>>> Is arbitrary HTML permitted in the link text?
>
> I had the same question when I was wondering about abusing $home_link=
_str
> to do this without a patch :-)

Not exactly arbitrary, as it is inside A element, so it cannot contain =
A links
itself (hyperlinks should not be nested), but it is not esc_html-aped.

>
>>> I think it makes sense to permit it for consistency with $home_link=
_str,
>>> but it might be worth mentioning in the manpage so the administrato=
r
>>> knows not to set it to something user-controlled --- e.g.:
>
> I left this detail out of the man page for consistency with the
> documentation for $home_link_str.

It would be better to improve documentation, than follow current bad
practice... ;-P

>> Nb. it would be nice to have relation of @extra_breadcrumbs with
>> $home_link_str explained.
>
> I will make that clearer.

Perhaps even make ( [ $home_link_str, $home_link ] ) to be default
value for @extra_breadcrumbs, making new feature generalization
of $home_link*, similarly to how it was done for $stylesheet -> @styles=
heets
transition.

What do you think about it?
--=20
Jakub Nar=C4=99bski
