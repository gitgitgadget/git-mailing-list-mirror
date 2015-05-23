From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Sat, 23 May 2015 18:53:41 +0700
Message-ID: <CACsJy8B7tUiRqw0ogLFaHfDo2RwVN8BP09uBQBGVOA9eHtWLvw@mail.gmail.com>
References: <555FD1EA.2060706@rightscale.com> <CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
 <20150523022256.GA17789@lanh> <556004DE.7080504@rightscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thorsten von Eicken <tve@rightscale.com>
X-From: git-owner@vger.kernel.org Sat May 23 13:54:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yw80Q-0006LV-VA
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 13:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946AbbEWLyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 07:54:13 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33461 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbbEWLyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 07:54:12 -0400
Received: by igbpi8 with SMTP id pi8so9568399igb.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NEGN4q65CusUOhIxv8VD32GXZ0CQUUKaFZsQLZyvXys=;
        b=Ju43rNmR3o0cwK9buqJNgA9CDaSx1rVwpYdHZJoelIEfAkhoYebnHIqL9+ktjzvi+0
         jyTO2AM7AmNP5m+RLpUWbmx7NPMqvAtbdLN3CC5dmTok8Rmrbi11Txz9Yi/BlZsuejhR
         3eT4rD3FWjTlpthsx3TCKycwsYRvSbaALltaWubCwiukCOrUIJLwkyi+dHbgvTpbcR4F
         6NRiujbR9BcK1vSfukoAt7wTjXnCgXmSWDwaz/xQmwUzK1Zx1epWgEDmGrFwU2dxfZYw
         UH5P6ppRE3ZoPGieyPxY0UVd/lFmS2TC4FKJ+/PnnY172xYVbPsDoW6j7oy1MKwK1tmQ
         rptw==
X-Received: by 10.50.4.66 with SMTP id i2mr5646944igi.40.1432382051638; Sat,
 23 May 2015 04:54:11 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Sat, 23 May 2015 04:53:41 -0700 (PDT)
In-Reply-To: <556004DE.7080504@rightscale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269801>

On Sat, May 23, 2015 at 11:41 AM, Thorsten von Eicken
<tve@rightscale.com> wrote:
> On 5/22/2015 7:22 PM, Duy Nguyen wrote:
>> On Fri, May 22, 2015 at 07:03:48PM -0700, Junio C Hamano wrote:
>>> As far as I know, GIT_DIR was prepared as a mechanism to point at
>>> another .git directory that does not live inside the working tree, not
>>> as a mechanism to rename it to arbitrary name. E.g.
>>>
>>>  $ git init
>>>  $ mv .git .svn
>>>  $ GIT_DIR=$(pwd)/.svn ; export GIT_DIR
>>>
>>> is not expected to work.
>>
>> ++
>> +Note that if GIT_DIR is set explicitly to a directory inside working
>> +tree, the directory name must be ".git".
> This is not at all what I was hoping to hear, but thanks for the response.

To elaborate a bit more, I think ".git" was cooked in the code near
the beginning and for too long. By the time people wanted flexibility,
".git" string was already all over the place and changing it may
require some (and maybe big) code reorganization, and all that is for
a rare use case.. I think I saw at least two attempts to fix this but
they went nowhere. On the bright side, you can work around this easily
by adding ".svn" to your ignore list.
-- 
Duy
