From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 14/16] refs: allow ref backend to be set for clone
Date: Wed, 23 Dec 2015 15:23:25 -0500
Message-ID: <CAPig+cSaZRAXJ+sVZgFUbWcNMzqWGtH9rgqFXjupjtTJiQVYFw@mail.gmail.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-15-git-send-email-dturner@twopensource.com>
	<567AA6DD.9000404@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 23 21:23:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBpwZ-0002gG-3O
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 21:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934203AbbLWUX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 15:23:27 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35112 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934182AbbLWUX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 15:23:26 -0500
Received: by mail-vk0-f46.google.com with SMTP id k1so11903572vkb.2
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 12:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JPgXUP0jt0tZc1faJAzLpUsvvgJpw4/warCrm8NYWKc=;
        b=cs8GE/bKPfiWgHpcFoVNE63nWp0IjJTEam1UfrVBxrqPox8AZ43Jkg/AxWCZVaF5V/
         bcRqpDCMDxP+g6HEKWJX8gte+oLcQMAqV/xUP5XpUdf2zEeuGmguBJ0mRXArU3eCueau
         lKGneoCjV8VQKKw6s30FRPIcqOFfHMsKHzFHZze7wnT9qOLUGXrEeBKqgHRrSp4uFXg9
         /RJmv7QWFEPVwHCew3WEMzpeyJIY6CGRMZaLK6XWrtkkd8rUMpwxKuZutlOENG0nML3Q
         7BRbKtr7upv4O7+dL0lpCpKUOnsldXMgiaU9WC5f9nWfOkaaNmnd3/dCTuRSr9WMwA35
         ALZw==
X-Received: by 10.31.52.82 with SMTP id b79mr21108154vka.84.1450902205613;
 Wed, 23 Dec 2015 12:23:25 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 23 Dec 2015 12:23:25 -0800 (PST)
In-Reply-To: <567AA6DD.9000404@alum.mit.edu>
X-Google-Sender-Auth: eSiT5-i1S2FOO4uRoRGmcCjej0s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282952>

On Wed, Dec 23, 2015 at 8:51 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/03/2015 01:35 AM, David Turner wrote:
>> +     if (refs_backend_type && *refs_backend_type) {
>> +             argv_array_push(&cp.args, "--refs-backend-type");
>> +             argv_array_push(&cp.args, refs_backend_type);
>> +     }
>
> This could be shortened to
>
>     argv_array_pushf(&cp.args, "--refs-backend-type=%s", refs_backend_type);

Or, without interpolation:

    argv_array_pushl(&cp.args, "--refs-backend-type", refs_backend_type, NULL);
