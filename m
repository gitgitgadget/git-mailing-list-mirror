From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 00:53:55 +0000
Message-ID: <1355273635-ner-4863@calvin>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
	<CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
	<CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:54:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiaaY-0001LU-DM
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 01:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab2LLAyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 19:54:00 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:41585 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab2LLAx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 19:53:59 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so48960wgb.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=HfoOobAgTdYKipFr3pVROw3FnqtFPR9ixp4pngIgaaE=;
        b=jGTrxqG5WXt9GImcvv1zqwCWxmF0lN89QdvnC+y3PCbpQfV4x51zOYbQrgJQaosasy
         X0VV1Bb0LAqEAg8+UdPi9WrYDKgGLJ5plakPslKbx3NAVwguiUwaQXDb+OYvenN7caw2
         LQW1tftgJWS83KsgpmyN2J6hwl83DFjDuvTMyFbjhLD8mASMpYHmJcRMdkX5mvWHevAu
         dwRHzWR/3GnOI4OC2/eBhRIh16wUUqQcn0E8E+IFIOBY3GwvgRQewEoVGYv5eBRscRGf
         0C8NrnwXgta86AtHThcVl6BJ3whQs7vs/B7XJK7ZyA/jQMCw3BK6YrhwrIf37QyRczUq
         AY+g==
Received: by 10.194.238.5 with SMTP id vg5mr3678104wjc.40.1355273638256;
        Tue, 11 Dec 2012 16:53:58 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id gz3sm1055839wib.2.2012.12.11.16.53.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 16:53:57 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 7A6821130AF; Wed, 12 Dec 2012 00:53:55 +0000 (UTC)
In-Reply-To: <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211321>

On Wed, 12 Dec 2012 05:39:43 +0530, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Does lua have os.putenv() yet?  The inability to even *set* an env var
> before calling something else was a killer for me when I last tried
> it.

If it doesn't, it would be trivial to add. It's a one-liner. It's been a while
since I used Lua, but it would be something like this:

    void L_putenv(lua_State *L) {
        putenv(lua_tostring(L, 1));
    }

and then somewhere during setup:

    lua_register(L, "putenv", L_putenv);
