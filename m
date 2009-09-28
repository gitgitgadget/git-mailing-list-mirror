From: Michael Wookey <michaelwookey@gmail.com>
Subject: [PATCH] generators/vcproj.pm: remove UNICODE from build
Date: Mon, 28 Sep 2009 20:46:52 +1000
Message-ID: <d2e97e800909280346s12c205f2gf95ff4c135d4625c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 12:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsDlH-0002B8-UM
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 12:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbZI1KrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 06:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbZI1KrJ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 06:47:09 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:62208 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbZI1KrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 06:47:08 -0400
Received: by yxe37 with SMTP id 37so5034348yxe.33
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=gqGuGJVvtga7cSH6s7hqhePdmnRTbs1U3vWXCWvpTUY=;
        b=ku9gNcRLH3V/WFhR5gslbvsWQ61QIrXgwLhu8QVmIil8aY4sC4Kj0XW9W/HJdSttU/
         JOrfmHnTXjzMaLPgX6/MKgw6IIRKQ9B/q7DdJItT4GHQYFEch7rt5oUmDJajCCkn27AF
         4FEwtNfSXBiSvB1cUrToj7/t/v77jvR/qXYi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ME+Emihkrph2tD8pIZCDXPHGzSj3mSeMVX3y4ewwyLruQrvZIW/qQdNowBMP3O47uw
         6RlXynZsApv/qOOCy88OEFLydjHLYobJWLTri0ZmOkUYjxXHdnnMa0r9e+qh13uoQwEO
         IXXo80csdaTpTm/Bm+g4dJiYm5T73LeH0LeNw=
Received: by 10.101.129.9 with SMTP id g9mr2841308ann.115.1254134832247; Mon, 
	28 Sep 2009 03:47:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129248>

Defining UNICODE for MSVC IDE builds results in certain Win32 WIDE API's
receiving ANSI strings. The result of which is an invalid use of the API
and will end in either data corruption or an application crash.

Prevent the use of WIDE API's when building with the MSVC IDE for
compatibility with msysGit.

Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
---
 contrib/buildsystems/Generators/Vcproj.pm |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm
b/contrib/buildsystems/Generators/Vcproj.pm
index 00ec0c1..a215911 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -173,7 +173,7 @@ sub createLibProject {
 				Optimization="0"
 				InlineFunctionExpansion="1"
 				AdditionalIncludeDirectories="$includes"
-				PreprocessorDefinitions="UNICODE,WIN32,_DEBUG,$defines"
+				PreprocessorDefinitions="WIN32,_DEBUG,$defines"
 				MinimalRebuild="true"
 				RuntimeLibrary="1"
 				UsePrecompiledHeader="0"
@@ -239,7 +239,7 @@ sub createLibProject {
 				InlineFunctionExpansion="1"
 				EnableIntrinsicFunctions="true"
 				AdditionalIncludeDirectories="$includes"
-				PreprocessorDefinitions="UNICODE,WIN32,NDEBUG,$defines"
+				PreprocessorDefinitions="WIN32,NDEBUG,$defines"
 				RuntimeLibrary="0"
 				EnableFunctionLevelLinking="true"
 				UsePrecompiledHeader="0"
@@ -395,7 +395,7 @@ sub createAppProject {
 				Optimization="0"
 				InlineFunctionExpansion="1"
 				AdditionalIncludeDirectories="$includes"
-				PreprocessorDefinitions="UNICODE,WIN32,_DEBUG,$defines"
+				PreprocessorDefinitions="WIN32,_DEBUG,$defines"
 				MinimalRebuild="true"
 				RuntimeLibrary="1"
 				UsePrecompiledHeader="0"
@@ -466,7 +466,7 @@ sub createAppProject {
 				InlineFunctionExpansion="1"
 				EnableIntrinsicFunctions="true"
 				AdditionalIncludeDirectories="$includes"
-				PreprocessorDefinitions="UNICODE,WIN32,NDEBUG,$defines"
+				PreprocessorDefinitions="WIN32,NDEBUG,$defines"
 				RuntimeLibrary="0"
 				EnableFunctionLevelLinking="true"
 				UsePrecompiledHeader="0"
-- 
1.6.5.rc2
