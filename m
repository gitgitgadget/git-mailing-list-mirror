From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Wed, 2 Mar 2016 05:06:31 +0000
Message-ID: <CAE5ih7_EAjMtdNQ6ab2wrN4LMSBBZ=T7w-fPKLtdRqfvFUhzFQ@mail.gmail.com>
References: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
	<CAPig+cRwEKjGaDA-jy8KJSAhTheJYDmxtPq8SdVs0LA2f9-9Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Lars Schneider <lars.schneider@autodesk.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 06:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aayzj-0007SX-9U
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 06:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbcCBFGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 00:06:33 -0500
Received: from mail-ob0-f193.google.com ([209.85.214.193]:33037 "EHLO
	mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbcCBFGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 00:06:32 -0500
Received: by mail-ob0-f193.google.com with SMTP id hc1so6416601obb.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 21:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=IgTnoJSjcPLkZYZ9XneskrIwYIO11gMzfmC4OK28qo4=;
        b=NzcfmG1NuApmZGLMOXqYqAPJ/h1TNqq32/POwdAdvr7QEU+Z+Q3myCBsRgVDiVhjQW
         wN7AoEqYMs9DRlhwTtk9dg+n8kFi+gtqGjw9hxuKt6sH/zyDZ5cqI0Dg/G4WK6Hk5xzD
         tjqZulf2T/moDO5+WoQB6hf81imgYmtn/mUgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IgTnoJSjcPLkZYZ9XneskrIwYIO11gMzfmC4OK28qo4=;
        b=VjYy2XkfoT2d3W1fzNoUDQpwCIDSE0T1egvku7pjjYLjwmdfKjbbuPzvzAS22HDGP+
         R/S4JzqLTPT9lrIBq0zCy1N11KITKv0P1N4vS4V4KRyDFRyoRo4mwu7vXsPQBLRsrNWg
         ElAbmyIQphc/p9QfQkg9pNqsrZAJScpCzClwS6Iz28q4CSqqGR43mt0iPaQeBx6zCXGR
         l+TQOsSLyF/NXQ8oIc6mMGSsMc19ZeviXQsz7KoNgZhq/s/ZpnS5DjgVQG37u4CWhoDn
         4Jzxvc6lIUEukVMk9+vdoiaDMQK118rXasDs7N6scz9/gudzSh1AT5dyizRCNx1D5oDS
         ChOQ==
X-Gm-Message-State: AD7BkJITd45mTtEpkSwAUzssln6X8N77tJ16V3e9CLK0JDCuT3JAPvlwv6+H19AKhLOQXQgU1AhaP7I5oaXORg==
X-Received: by 10.60.142.170 with SMTP id rx10mr18827765oeb.37.1456895191623;
 Tue, 01 Mar 2016 21:06:31 -0800 (PST)
Received: by 10.202.172.132 with HTTP; Tue, 1 Mar 2016 21:06:31 -0800 (PST)
In-Reply-To: <CAPig+cRwEKjGaDA-jy8KJSAhTheJYDmxtPq8SdVs0LA2f9-9Yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288095>

On 1 March 2016 at 19:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 1, 2016 at 5:49 AM,  <larsxschneider@gmail.com> wrote:
>> Map a P4 user to a specific name and email address in Git with the
>> "git-p4.mapUser" config. The config value must be a string adhering
>> to the format "p4user = First Lastname <email@address.com>".
>>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> +git-p4.mapUser::
>> +       Map a P4 user to a name and email address in Git. Use a string
>> +       with the following format to create a mapping:
>> ++
>> +-------------
>> +git config --add git-p4.mapUser "p4user = First Last <mail@address.com>"
>> +-------------
>> ++
>> +A mapping will override any user information from P4. Mappings for
>> +multiple P4 user can be defined.
>
> Sorry for not paying closer attention the first time, but this needs
> to be repeated for each P4 user you want to map, right? One can
> imagine this quickly becoming painful if you have a lot of users to
> map. Have you considered modeling this after git-svn where you can set
> an "authors" file (and name the corresponding option --authors-file)?

For most authors it should just use the existing Perforce user
information. This is (I assume) just for the occasional exception
where Perforce has the wrong email address.

Luke
