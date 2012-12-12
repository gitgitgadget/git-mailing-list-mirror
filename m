From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 08:50:27 +0700
Message-ID: <CACsJy8A9h4QJ_iWvQqTtYa4NPH6Q1Gy0NTozbgukC3=ep58mLA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu> <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com> <1355273635-ner-4863@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 02:56:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TibZ6-0006nD-4i
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 02:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab2LLB4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 20:56:35 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:53203 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab2LLB4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 20:56:34 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Dec 2012 20:56:34 EST
Received: by mail-ob0-f181.google.com with SMTP id oi10so127916obb.12
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 17:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=I/V1wqaS5AjRufbLjibt08nzTxSJblumqCqrB94iKdY=;
        b=XJdrtbz3keWEeDkKnC1FwsO5cvAZF8LsZ/NaENgWpMuUTv3nSo4BnttEZFflRcLJW7
         8rz0mgL9VCy717tgy3VooqNJ8UYysewmD3eMnNSqY5YnvtUExFDS5CHNRilh8kNlWKep
         F9QBAHBD/gF8AgK4Bm4fKj8wnjpPm4pLv3V4hxYWNw0zYYIq4Tx4Gb67kEhVk7hSXQ32
         vClb5s5Yny9IWsPr0GskRawFBUpIFXHAYOCHkKkayyPSwhiMZHMmuKO2aciEQYCtV2Y7
         5LVmgmpMTklPU4stTBNCO+CwSKLn0KhXIbRyK4fE0OFPaSmXpcaEwhDi2YuAtrIlSKD0
         Q8ow==
Received: by 10.182.141.70 with SMTP id rm6mr51831obb.59.1355277058117; Tue,
 11 Dec 2012 17:50:58 -0800 (PST)
Received: by 10.182.23.11 with HTTP; Tue, 11 Dec 2012 17:50:27 -0800 (PST)
In-Reply-To: <1355273635-ner-4863@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211322>

On Wed, Dec 12, 2012 at 7:53 AM, Tomas Carnecky
<tomas.carnecky@gmail.com> wrote:
> If it doesn't, it would be trivial to add. It's a one-liner. It's been a while
> since I used Lua, but it would be something like this:
>
>     void L_putenv(lua_State *L) {
>         putenv(lua_tostring(L, 1));
>     }
>
> and then somewhere during setup:
>
>     lua_register(L, "putenv", L_putenv);

I should have done my homework before asking, but well.. is there any
way to automate this? If we use lua for writing "builtin" commands,
we'll need to export a lot of C functions and writing wrappers like
this is boring and time consuming. Also, assume I export fn(char*,int)
to Lua, then I change the prototype to fn(char*, char*), can Lua spot
all the call sites at compile time (or something) so I can update
them?
-- 
Duy
