Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1EF4086A
	for <git@vger.kernel.org>; Thu, 22 May 2025 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747883038; cv=none; b=DGiTBt28VY5t776mpr57XlcQOiPIDgWdjLoUwK98H6QnaIn9k5gzpGkFCuW8Zm59x02lT3iHHrNehfxiNbvJprQVWQ8E4eFhs985G2SQxXrKIo7dg1rAmZvHAJmjfHwkz/RREEb6szs1wpYHC+EqsJmWx+wesdSOE6kcniMHM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747883038; c=relaxed/simple;
	bh=x+PQ9jl3mzsSTW0hzM2bGyCjDU2lqppbs3ZGmRn7OG0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XoUXHGkRTH8ujmcwGqnNziW79BAfIxSaP5i68v3JANAG1HFVFTz4/2LOIwRN0fAG4WpMTt/9ACV12zAZKTqUvjqcC2SeAXX5ZUYx9DI2bn2k/wiGTaBE0XFmKb+epgQwHEEZde6z6fE1n2081FWR2VfDeZ4TPduVVA5Y7Jvci9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kV8Aqfv5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCjTI5Xu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kV8Aqfv5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCjTI5Xu"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A902911403D2
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:03:55 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-05.internal (MEProxy); Wed, 21 May 2025 23:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747883035;
	 x=1747969435; bh=pgGVt6xGJp2TNkK2v8xkkoAcPjNStY5qDCBrNS6IpIg=; b=
	kV8Aqfv5Ipys6iQFDkECajo++ylMAcWqMC5I9D5XQtT6qSnLJFUHoz70+zMh/3L7
	Boagp9CGC2P+Igkvr1MQI3vmXrHakZoVPFGBtIsMafyUYSUQOCA9+qUEIgaTtUFY
	hoM22i7mzKCQ5bJ21nl4kO/nFggk73hDaiHU/T3O9XKssBaFMFjpGpQESQ0US0Zt
	Wq4AgrxJXV2JVWpchEGfTy7lXKUyjqwEb9CziJYuUVLxB67tWeOwNIR8Fn/OrAT8
	xsyQnJj7sug279K9iT5w+2HYrx/mWj62I+MibtHJ9TXl0JW6CZaUEeK3kULz4S2v
	bK7qgoWmFdy/S1/Rwe54Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747883035; x=1747969435; bh=p
	gGVt6xGJp2TNkK2v8xkkoAcPjNStY5qDCBrNS6IpIg=; b=PCjTI5Xu3DS4qr7WZ
	o9VqVmL50uJF43aagatUfVaPMf8Rq0VrwAV9QY+iM+PPUwZIY/LUTTRm+jrTL7CR
	ICM4ZXFAPZE27Zc7QghiyTclKGkwATVXUReG87Ryw5oJxrTVZ45inFrfIFN35wxD
	u5joS+bI2C+Wj4P+bOGPIm7881kHNaG4cmnwNojsEVos+Fghps/zjwkgyAhSJJ3G
	wKpu4gIuezAVvmRlZBoj8dfTISvloSYx0JPp6EE/Rdr6cWGXkr27TisElV806rR3
	D3Omh1fI3pB5P1dPGvwZ236ChTlqbo4pZ48K67gee+/2jmuHrUeu+A4Dx1eakKLP
	lqcHQ==
X-ME-Sender: <xms:G5QuaDssHdJZGe00dk2Dy8jotvR1v_14o3oar5fmNl_czn_y0TqVYw>
    <xme:G5QuaEfzguSGlWm_Ubf23eUKjug1P4u19PWNdvbk1t3jFH2YvWUxslsitUCWKTAvP
    dohzgkKoXcUNuI5IL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegkeefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpehp
    uhhnkhdrlhhiohhntdeltdeisehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrh
    hnpeekffdvieeijefgudeuhfekkeelueduuedvvdduffekueelfefgfeevvdevjeehveen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhunhhkrdhlihhonhdtledtieesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:G5QuaGy3J8HqOobUR6r-3f2IvBuk9uAKG1O6SrQiFWDzfGp4ogKRow>
    <xmx:G5QuaCONJ_FiYK6C2mCW2eZxJkrKQgKrznRUhXNzu-EaQwifkpOTDg>
    <xmx:G5QuaD9OLOlOVTRcQNOis9_qYIpA5qnlkQym5vVbLk9fo-QChalDUw>
    <xmx:G5QuaCWHJFs9uWriBYcUk-R7Vz_yOe0xliV2G0ME5abqJDowVrmyIg>
    <xmx:G5QuaPRSIy8_0_CBYadqcSoAkf1RdGS4j9yt8MqUlLJohFMHxIHpBq9L>
Feedback-ID: i35d941ae:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 548C93020061; Wed, 21 May 2025 23:03:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4426678c4e746db6
Date: Wed, 21 May 2025 20:03:35 -0700
From: punk.lion0906@fastmail.com
To: git@vger.kernel.org
Message-Id: <55a7668d-5227-4b7e-93f9-40d049f2e1be@app.fastmail.com>
In-Reply-To: <087f6a4d-d276-4f1e-94a4-7423b3387b79@app.fastmail.com>
References: <087f6a4d-d276-4f1e-94a4-7423b3387b79@app.fastmail.com>
Subject: Re: gitk: regression when opening preferences with `want_ttk=0`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Since the commit probably has a different id in Git's main repo,
here is the description of the problematic commit 904b36b:

```
gitk: add text wrapping preferences
Add a new preference "wrapdefault" which allows enabling char/word wrap.
Impacts all text in the ctext widget for which no other preference exists.

Also make the (existing) preference "wrapcomment" configurable graphically.
Its setting impacts only the "comment" part of the ctext widget.

Signed-off-by: Christoph Sommer <sommer@cms-labs.org>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
```

And the likely problematic section of the diff is:

```
@@ -11607,6 +11607,17 @@ proc prefspage_general {notebook} {
     ${NS}::label $page.tabstopl -text [mc "Tab spacing"]
     spinbox $page.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $page.tabstopl $page.tabstop -sticky w
+
+    ${NS}::label $page.wrapcommentl -text [mc "Wrap comment text"]
+    ${NS}::combobox $page.wrapcomment -values {none char word} -state readonly \
+        -textvariable wrapcomment
+    grid x $page.wrapcommentl $page.wrapcomment -sticky w
+
+    ${NS}::label $page.wrapdefaultl -text [mc "Wrap other text"]
+    ${NS}::combobox $page.wrapdefault -values {none char word} -state readonly \
+        -textvariable wrapdefault
+    grid x $page.wrapdefaultl $page.wrapdefault -sticky w
+
     ${NS}::checkbutton $page.ntag -text [mc "Display nearby tags/heads"] \
         -variable showneartags
     grid x $page.ntag -sticky w
```

Hopefully, this will make it easier to find for people.

        Ilya.

On Wed, May 21, 2025, at 7:55 PM, punk.lion0906@fastmail.com wrote:
> This duplicates https://github.com/j6t/gitk/issues/18.
>
> I found a regression in `gitk`'s commit 904b36b. When `gitk` is run 
> with `want_ttk=0`
> (AKA "use themed widgets" set to off), I cannot open the settings 
> dialog since that
> commit.  It gives the following error in a modal dialog, and then opens 
> a completely empty non-modal dialog where the settings dialog should be:
>
> ```
> `invalid command name "::combobox"
> invalid command name "::combobox"
>     while executing
> "${NS}::combobox $page.wrapcomment -values {none char word} -state 
> readonly  -textvariable wrapcomment"
>     (procedure "prefspage_general" line 43)
>     invoked from within
> "prefspage_general $notebook"
>     (procedure "doprefs" line 27)
>     invoked from within
> "doprefs"
>     (procedure "::tk::mac::ShowPreferences" line 1)
>     invoked from within
> "::tk::mac::ShowPreferences"`
> ```
>
> Indeed, 904b36b adds some `::combobox`es.
>
> I tested this on MacOS with Tcl/Tk 8.6, both with Homebrew-installed 
> `gitk` from the `git-gui` 2.49.0 package, and with the master branch of 
> https://github.com/j6t/gitk (commit 9f27318), and with that repo's 
> 904b36b. The parent of 904b36b works fine.
>
> The workaround is to close gitk, and set `want_ttk` to 1 in 
> ~/.config/git/gitk, ~/.gitk, or equivalent. Completely deleting the 
> config file at ~/.config/git/gitk also fixed the problem for me.
>
>        Ilya.
