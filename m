From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 12/20] remote-hg: push to the appropriate branch
Date: Wed, 10 Apr 2013 14:15:53 -0500
Message-ID: <CAMP44s06gKHiEuZF41OkE7tsBn5PAkyGXvmoiqvN1keKFZczJQ@mail.gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
	<1365441214-21096-13-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 21:16:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0Ux-0003KL-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761615Ab3DJTPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:15:55 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:45728 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759513Ab3DJTPz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:15:55 -0400
Received: by mail-la0-f42.google.com with SMTP id fn20so498273lab.1
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8Gmo07kAx6wB1WI4SSu8bPnwIaJz7134VsTk+Cx3OWo=;
        b=juOUZg8EuqKpOTmka5/VjOfW6rKNYuVykgwDnFtRo8wnBMhM/NK/4qgFUOteYOrYAp
         sLnbcd3maVmAkHkwtcy2bbe0aK7SGhYGwIYeZZpKeq5d3iRuzOiq91cD9g8lLoiVHD7d
         irrOiU5/Zc6AYpzcImWO23GcoCKU4/uEh7/U94LlBqWPVggkFCanlY8FIv4GuOY48PbU
         MqnbNMeN5faR1HEAZGAgWBD6ZTqUdGHsrqzvJCk5wGvmqQls9Renjbh+UlUheqevGrYl
         bb/IdYuceEkutCH45V5NN565trCWXkkmW6GAG5o2Srmb3QsqOR1jneazw1qNzgyiko/L
         s46w==
X-Received: by 10.112.132.166 with SMTP id ov6mr1819883lbb.71.1365621353454;
 Wed, 10 Apr 2013 12:15:53 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Wed, 10 Apr 2013 12:15:53 -0700 (PDT)
In-Reply-To: <1365441214-21096-13-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220731>

On Mon, Apr 8, 2013 at 12:13 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -625,6 +625,10 @@ def parse_commit(parser):
>      if merge_mark:
>          get_merge_files(repo, p1, p2, files)
>
> +    # Check if the ref is supposed to be a named branch
> +    if ref.startswith('refs/heads/branches/'):
> +        extra['branch'] = ref.replace('refs/heads/branches/', '')

This should be more consistent with the rest of the code:

branch = ref[len('refs/heads/branches/'):]

Should I reroll?

--
Felipe Contreras
