Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BED1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 22:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934690AbeCCWji (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 17:39:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:60281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934610AbeCCWjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:36 -0500
Received: from localhost ([87.175.177.109]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lkwc9-1eK13V3El3-00anMz; Sat, 03
 Mar 2018 23:39:20 +0100
Date:   Sat, 3 Mar 2018 23:39:19 +0100
From:   Clemens Buchacher <drizzd@gmx.net>
To:     git@vger.kernel.org
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-gui: workaround ttk:style theme use
Message-ID: <20180303223919.GA5854@Sonnenschein.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Provags-ID: V03:K0:l80591e1cZ0D6bjKJquoljUx3cTEg5CIJ4RcnqbLy+NHCdyKA6m
 kDWp6ZGpv8ZgDtNojGFMS/1X4bLuHKkYkR7qYdMjk6f7JEViGJzClkgDI3tQd/a93j7bGUI
 CtuxJa3DzofRsfyOYPaOAhH3vAt6xzuq+rjaLCXCSjehLzMywLCLR9DnSn3OQYSC1kVKRAV
 NqK3rCk/ff+w21MfxJIwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bbYvHD6D19E=:hpaX7CHWpktEfNJsKFmEzi
 P1pViJ2kJ95+Dk1sSke9jJA8R0AWKCRWDZGJjxm68EOeAONx08fRhgRlPZ2LASOhQHi3bepwv
 znbYmasIaZv5arQSqEiGduSumQ+BEThqMfoaw2zziUhKT/LLNo7pRSro+wSCrqQCr2iksKyPp
 KTD8c0jLMdU6p3GifQA8Mq6HVgLSkzTlqONybA2NLdIwciOlOBYalpJuebz+c2cNi65li4hYa
 Qbsvxkp3MbJF3e9pawHOW0+h2w144KUHdsMVGVdY6Z9JahVNIzaB9eJ0gvj0czhKrtffqismK
 PudBpPD+dmxkuSHMcAAR6uw6MvMlH3EZF+UH7kaUl8uRN0CzWGPSqFWG7K5EvR9q1awxOlrTS
 NlHBMMy9PAxEHlkQoscYDb0L8hPLb8LLGg9xIbB4h9LGfgZeY7gmAKIitRCkLm230h378OGlQ
 sxmqdHIRY/LTTqJ96/kaydbCXe8BAY4VHSZ3H+Y/1kMC3UbmRQ9gNjF9vizFeRdcyrgxCoFha
 b8nk06CMZa3kOJ2LfYCx4UIxZ+M5ewbuU1iXbt2hrmAdgIKzaHgWujTNwgsx7lXblQui9+ibq
 VhsELTSGM8SJsKq8bST4nUwQ25PX+Zg3oQetGmrjOP6F7e6wMselJddHyqW8LgSl73y1H1w6l
 GJmT1VOtXjtsO7bR5PSZkE9F5xQhFgMFA85OEEOsjIot2otayRaAGJTuAjy4DU1ihoBqj1+tj
 xddVWrOQdkhHwFlke3/W4PrSV/8HMz71vM5DJo8/GAjfCEl4mitUAgCOz1DDBiOmpawjp5xqc
 xwKBdJnnc5iufxw/FASEsWBe1gQLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tk 8.5.7, which is the latest version on Centos 6, does not support
getting the current theme with [ttk::style theme use]. Use the existing
workaround for this in all places.

Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
---
 git-gui/lib/themed.tcl | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
index 351a712..88b3119 100644
--- a/git-gui/lib/themed.tcl
+++ b/git-gui/lib/themed.tcl
@@ -1,6 +1,14 @@
 # Functions for supporting the use of themed Tk widgets in git-gui.
 # Copyright (C) 2009 Pat Thoyts <patthoyts@users.sourceforge.net>
 
+proc ttk_get_current_theme {} {
+	# Handle either current Tk or older versions of 8.5
+	if {[catch {set theme [ttk::style theme use]}]} {
+		set theme  $::ttk::currentTheme
+	}
+	return $theme
+}
+
 proc InitTheme {} {
 	# Create a color label style (bg can be overridden by widget option)
 	ttk::style layout Color.TLabel {
@@ -28,10 +36,7 @@ proc InitTheme {} {
 		}
 	}
 
-	# Handle either current Tk or older versions of 8.5
-	if {[catch {set theme [ttk::style theme use]}]} {
-		set theme  $::ttk::currentTheme
-	}
+	set theme [ttk_get_current_theme]
 
 	if {[lsearch -exact {default alt classic clam} $theme] != -1} {
 		# Simple override of standard ttk::entry to change the field
@@ -248,7 +253,7 @@ proc tspinbox {w args} {
 proc ttext {w args} {
 	global use_ttk
 	if {$use_ttk} {
-		switch -- [ttk::style theme use] {
+		switch -- [ttk_get_current_theme] {
 			"vista" - "xpnative" {
 				lappend args -highlightthickness 0 -borderwidth 0
 			}
-- 
2.7.4

