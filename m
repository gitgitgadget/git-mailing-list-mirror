From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 11 Dec 2012 21:26:15 -0500
Message-ID: <CACh33FqTBOMar=V8=aiE2asZ_ri37fAqeghJLqGecYk=qtvBiQ@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
	<CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
	<CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
	<1355273635-ner-4863@calvin>
	<CACsJy8A9h4QJ_iWvQqTtYa4NPH6Q1Gy0NTozbgukC3=ep58mLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 03:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tic6i-000376-IS
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 03:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab2LLCbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 21:31:19 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:39822 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab2LLCbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 21:31:18 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2012 21:31:18 EST
Received: by mail-oa0-f50.google.com with SMTP id n16so179613oag.37
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 18:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=Jj0eQEEG5+WU5RiwR0abdQ0o8dN5KwRp94KYQE4kG4E=;
        b=HsKB9LvYVoLOpZhqKHG7w/exyAT+gK+ievxINyzDvtuF+4FC7CvbUzsobRMc879dLs
         V03d41dwn/YH24ddbvMM1i91cT+e5+NSAUZoxuzQL0HOE6qveuc9Fb5lsD3RgLDsBfaK
         WWQXlsYM8JUtmC11S3LAH9kcT4BIVSD5oZ45NNx93GrK6cTdYdsy3ewY9CWkA/uBS5ZJ
         A6UWKtaeSLIXDuQ1ewVntUvnaGoge9xZBln49zuPNViLP5nbhhNxo6PcmYoNTfLaRRlb
         QgWJJ6ZiEwF1u8CdttIPT+TRSrqXZhlLBy298eXA4UHpmJ8YiXJToIdkw3VZTD8ljWUN
         U50A==
Received: by 10.60.0.136 with SMTP id 8mr97171oee.35.1355279175396; Tue, 11
 Dec 2012 18:26:15 -0800 (PST)
Received: by 10.76.28.101 with HTTP; Tue, 11 Dec 2012 18:26:15 -0800 (PST)
In-Reply-To: <CACsJy8A9h4QJ_iWvQqTtYa4NPH6Q1Gy0NTozbgukC3=ep58mLA@mail.gmail.com>
X-Gm-Message-State: ALoCoQnniHhWSazemasOQn394Spkni9m4vcoaqr56CZUG5Qt7sLLI33ilYjLKboFuNOo3/JczgA8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211323>

Hi Duy,

On Tue, Dec 11, 2012 at 8:50 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Wed, Dec 12, 2012 at 7:53 AM, Tomas Carnecky
> <tomas.carnecky@gmail.com> wrote:
>> If it doesn't, it would be trivial to add. It's a one-liner. It's been a while
>> since I used Lua, but it would be something like this:
>>
>>     void L_putenv(lua_State *L) {
>>         putenv(lua_tostring(L, 1));
>>     }
>>
>> and then somewhere during setup:
>>
>>     lua_register(L, "putenv", L_putenv);
>
> I should have done my homework before asking, but well.. is there any
> way to automate this?

If you want these basic POSIX functions, use an existing library.

If you want to automate adding a number of application specific
functions, you can use swig or similar. AFAIK, all languages rely on
third party tools like swig to assist in automated binding generation.
Although, automated binding generation is usually used to make it easy
to export bindings for multiple languages easily. If Lua is going to
be used as a "standard" module glue language, using swig is really
overkill.

> If we use lua for writing "builtin" commands,
> we'll need to export a lot of C functions and writing wrappers like
> this is boring and time consuming. Also, assume I export fn(char*,int)
> to Lua, then I change the prototype to fn(char*, char*), can Lua spot
> all the call sites at compile time (or something) so I can update
> them?

If the API calls are generic (don't require special handling), you can
use some preprocessor magic to save time/space.

--
- Patrick Donnelly
