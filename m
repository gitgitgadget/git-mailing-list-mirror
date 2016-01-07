From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new repos
Date: Wed, 6 Jan 2016 19:31:14 -0800
Message-ID: <CAJo=hJt0U_XxYUmiGpZK+ZraA+CbcdgNMU-rnQfDS83Cve29ig@mail.gmail.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
 <567AA2DF.1020408@alum.mit.edu> <CACsJy8DQMBfSh1re0jMk1W=d9gYa2=6jqO+Q6bqam5WBY3hfmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 04:31:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH1IZ-0006dc-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 04:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbcAGDbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 22:31:36 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32772 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbcAGDbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 22:31:35 -0500
Received: by mail-vk0-f42.google.com with SMTP id i129so29291766vkb.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 19:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lC+cK5dILDJh6L6dshs7FcuZO9/THHoq+n1VCMkwPwA=;
        b=NlBuEclRb09Ktxn7X7rOO1IUSKIC/pIkU3KrdZUVHQ2rT5ZEoYM2T6kdj0HzTwBQZy
         G0n34Rfl13P+7iTXqO0UQbkw1L7QzvKHfzxuP9NNzVsmXxY+a5X+vE/racAJxXhqmzwU
         TOsA54IParLACg3ni+Euw86VNtqr+3OOco8SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=lC+cK5dILDJh6L6dshs7FcuZO9/THHoq+n1VCMkwPwA=;
        b=gnQNkk32dBTrbuF2UmDQEpH/+tozvlY7L2cqRngRBQPdJmTZrzD9cc3a6bRZPrVh0F
         4kGYvMr0iVRHOvKMdlHtwXCbRLqItSREUpMKKdMYRLeflOflDt1mwI7zEW7to6FSwmfy
         TZ0g/2kLSFR2G5YH1k/7U9OISZITBVGDA+ewJCRFueJ8Opw95+/odCU82ByLW8EQfIBK
         uiUiPLieGHHspZolJATKp3LB7UVUux8ZNvg/OE59rIvfSJdJDYM3w25t3Ia0bPPpNqTX
         h/G9bfZlY1cLKhnt2BQeDqtzvniPbX1m0+6cfjFn6htz8UTIG3pT8vxD0OLhJcD+RDOT
         Nd+A==
X-Gm-Message-State: ALoCoQlA7I2asyFv/aRpg2lUj4kWmW0YSj5PkGsvVGF2kZFYNXZhyM/E4B5IBIfbt20ocYy9uU5MkUUd+cO/xdCxmGrFU3jbxw==
X-Received: by 10.31.149.3 with SMTP id x3mr6145422vkd.46.1452137493847; Wed,
 06 Jan 2016 19:31:33 -0800 (PST)
Received: by 10.103.97.65 with HTTP; Wed, 6 Jan 2016 19:31:14 -0800 (PST)
In-Reply-To: <CACsJy8DQMBfSh1re0jMk1W=d9gYa2=6jqO+Q6bqam5WBY3hfmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283466>

On Wed, Jan 6, 2016 at 4:52 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Dec 23, 2015 at 8:34 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 12/03/2015 01:35 AM, David Turner wrote:
>>> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
>>> index 8174d27..9ea6753 100644
>>> --- a/Documentation/git-init.txt
>>> +++ b/Documentation/git-init.txt
>>> @@ -12,7 +12,7 @@ SYNOPSIS
>>>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
>>>         [--separate-git-dir <git dir>]
>>>         [--shared[=<permissions>]] [directory]
>>> -
>>> +       [--refs-backend-type=<name>]
>>
>> ISTM that "backend" (used here in this option name, and in the manpage)
>> is not such a meaningful term to users. Could we pick a less obscure
>> term? E.g., maybe "--ref-storage=<name>"?
>
> From an (ex-)translator point of view, storage is also easier to
> translate than the technical term "backend". I know we do not
> translate option names, but whatever term you use usually show up in
> some user-facing messages that need translating. But I do prefer
> backend in source code, I think it expresses the idea much better than
> storage.

And JGit calls these things RefDatabases. Because Java.

Also, its a table of ref -> SHA-1.
And you put tables into databases.
Or something.

</two-cents>
