From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] wincred: improve compatibility with windows versions
Date: Fri, 04 Jan 2013 21:28:48 +0100
Message-ID: <50E73B80.4070105@gmail.com>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, kusmabite@gmail.com, 
 Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: msysgit+bncBCH3XYXLXQDBBAPXTSDQKGQEWB7IEDA@googlegroups.com Fri Jan 04 21:29:07 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBAPXTSDQKGQEWB7IEDA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBAPXTSDQKGQEWB7IEDA@googlegroups.com>)
	id 1TrDt3-0000HG-U8
	for gcvm-msysgit@m.gmane.org; Fri, 04 Jan 2013 21:29:06 +0100
Received: by mail-wg0-f63.google.com with SMTP id dq12sf7028035wgb.18
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jan 2013 12:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=WVO9EbAi6QK9Sd7dCwQbto/AFPsDaw3KBSavLBQrX+A=;
        b=s0D32aFEuViTn0VCZwA+nOKQhImeJ5TqPOdz+ThGVoo4UH5RN3pUIjD0jUkfK1elut
         YggTZR07wuubYpDNtkGkL1Y1XLpPav/ddiwwjUjqKglYvQXjbJhxwKUxfVJwVS74Y5Hc
         nNC4ijieV2rp29cFtT8cZALKxRr09DSyVpmtmwxMDkDB0Lch0/kmrH2y5pJNAOD0Tffa
         nNaCVBL14KiCJJcgl2QK5rt/N+Ioz0Mq2F6Gx/tC1j+dYx+GTO18TUxWVJHfzHhld0iU
         xskf5zQSjXvvCQ6t/UeE61cpmyRPSBcJp0JFbp8wfAJ/ 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=WVO9EbAi6QK9Sd7dCwQbto/AFPsDaw3KBSavLBQrX+A=;
        b=Xvpf/D+o5KpKe5+nfzBoxnmD/F0LlHqjrTkNdLlxITSBy0jqvME1hNfht30GYaldTE
         f2mMkdgkhqYqta2AeYsutYz+vR52VA3fThvjHsOO3VJ5qjQSLkSLpYianxuvPDf1ADIu
         KaNXPOQALCy1JjjJC/BFFSC9YR7Jp8h9KbgTxCJIvd96/c/AtDVGRrJAeKxLRkSFqWJk
         ddKSuHhlRLizVbwCeN5Uiu71q3BWIIWWK5HvAR0vEi+9UfgsP/rd/0mtBptXtbj7xcue
         mCb2uli4bujYfDBxNqyU23QPfqoAcN4wRQ24+OKMuqciDhTqsfL 
X-Received: by 10.180.105.7 with SMTP id gi7mr9736710wib.1.1357331330660;
        Fri, 04 Jan 2013 12:28:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.19.101 with SMTP id d5ls90895wie.37.canary; Fri, 04 Jan
 2013 12:28:49 -0800 (PST)
X-Received: by 10.14.208.198 with SMTP id q46mr68165784eeo.0.1357331329436;
        Fri, 04 Jan 2013 12:28:49 -0800 (PST)
X-Received: by 10.14.208.198 with SMTP id q46mr68165782eeo.0.1357331329414;
        Fri, 04 Jan 2013 12:28:49 -0800 (PST)
Received: from mail-ee0-f67.google.com (mail-ee0-f67.google.com [74.125.83.67])
        by gmr-mx.google.com with ESMTPS id g9si4683361eeo.1.2013.01.04.12.28.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Jan 2013 12:28:49 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 74.125.83.67 as permitted sender) client-ip=74.125.83.67;
Received: by mail-ee0-f67.google.com with SMTP id l10so11962810eei.2
        for <msysgit@googlegroups.com>; Fri, 04 Jan 2013 12:28:49 -0800 (PST)
X-Received: by 10.14.215.197 with SMTP id e45mr147019401eep.0.1357331329271;
        Fri, 04 Jan 2013 12:28:49 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id 6sm112794927eea.3.2013.01.04.12.28.47
        (version=SSLv3 cipher=OTHER);
        Fri, 04 Jan 2013 12:28:48 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of karsten.blees@gmail.com designates 74.125.83.67 as permitted
 sender) smtp.mail=karsten.blees@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212637>

On WinXP, the windows credential helper doesn't work at all (due to missing
Cred[Un]PackAuthenticationBuffer APIs). On Win7, the credential format used
by wincred is incompatible with native Windows tools (such as the control
panel applet or 'cmdkey.exe /generic'). These Windows tools only set the
TargetName, UserName and CredentialBlob members of the CREDENTIAL
structure (where CredentialBlob is the UTF-16-encoded password).

Remove the unnecessary packing / unpacking of the password, along with the
related API definitions, for compatibility with Windows XP.

Don't use CREDENTIAL_ATTRIBUTEs to identify credentials for compatibility
with Windows credential manager tools. Parse the protocol, username, host
and path fields from the credential's target name instead.

While we're at it, optionally accept CRLF (instead of LF only) to simplify
debugging in bash / cmd.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

Hi,

I tried the windows credential helper yesterday and found that it doesn't work on XP at all, and doesn't work properly in combination with Win7 credential manager tools. So here's a patch that reduces it to the functionality provided / expected by Windows.

@Erik, Jeff: Please let me know if I'm missing something and the use of Cred[Un]PackAuthenticationBuffer or CREDENTIAL_ATTRIBUTEs actually served a useful purpose.

Cheers,
Karsten

Also available here:
https://github.com/kblees/git/tree/kb/improve-wincred-compatibility
git pull git://github.com/kblees/git.git kb/improve-wincred-compatibility

---
 .../credential/wincred/git-credential-wincred.c    | 179 ++++++---------------
 1 file changed, 53 insertions(+), 126 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index cbaec5f..3464080 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -9,6 +9,8 @@
 
 /* common helpers */
 
+#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
+
 static void die(const char *err, ...)
 {
 	char msg[4096];
@@ -30,14 +32,6 @@ static void *xmalloc(size_t size)
 	return ret;
 }
 
-static char *xstrdup(const char *str)
-{
-	char *ret = strdup(str);
-	if (!ret)
-		die("Out of memory");
-	return ret;
-}
-
 /* MinGW doesn't have wincred.h, so we need to define stuff */
 
 typedef struct _CREDENTIAL_ATTRIBUTEW {
@@ -67,20 +61,14 @@ typedef struct _CREDENTIALW {
 #define CRED_MAX_ATTRIBUTES 64
 
 typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
-typedef BOOL (WINAPI *CredUnPackAuthenticationBufferWT)(DWORD, PVOID, DWORD,
-    LPWSTR, DWORD *, LPWSTR, DWORD *, LPWSTR, DWORD *);
 typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
     PCREDENTIALW **);
-typedef BOOL (WINAPI *CredPackAuthenticationBufferWT)(DWORD, LPWSTR, LPWSTR,
-    PBYTE, DWORD *);
 typedef VOID (WINAPI *CredFreeT)(PVOID);
 typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
 
 static HMODULE advapi, credui;
 static CredWriteWT CredWriteW;
-static CredUnPackAuthenticationBufferWT CredUnPackAuthenticationBufferW;
 static CredEnumerateWT CredEnumerateW;
-static CredPackAuthenticationBufferWT CredPackAuthenticationBufferW;
 static CredFreeT CredFree;
 static CredDeleteWT CredDeleteW;
 
@@ -88,74 +76,64 @@ static void load_cred_funcs(void)
 {
 	/* load DLLs */
 	advapi = LoadLibrary("advapi32.dll");
-	credui = LoadLibrary("credui.dll");
-	if (!advapi || !credui)
+	if (!advapi)
 		die("failed to load DLLs");
 
 	/* get function pointers */
 	CredWriteW = (CredWriteWT)GetProcAddress(advapi, "CredWriteW");
-	CredUnPackAuthenticationBufferW = (CredUnPackAuthenticationBufferWT)
-	    GetProcAddress(credui, "CredUnPackAuthenticationBufferW");
 	CredEnumerateW = (CredEnumerateWT)GetProcAddress(advapi,
 	    "CredEnumerateW");
-	CredPackAuthenticationBufferW = (CredPackAuthenticationBufferWT)
-	    GetProcAddress(credui, "CredPackAuthenticationBufferW");
 	CredFree = (CredFreeT)GetProcAddress(advapi, "CredFree");
 	CredDeleteW = (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
-	if (!CredWriteW || !CredUnPackAuthenticationBufferW ||
-	    !CredEnumerateW || !CredPackAuthenticationBufferW || !CredFree ||
-	    !CredDeleteW)
+	if (!CredWriteW || !CredEnumerateW || !CredFree || !CredDeleteW)
 		die("failed to load functions");
 }
 
-static char target_buf[1024];
-static char *protocol, *host, *path, *username;
-static WCHAR *wusername, *password, *target;
+static WCHAR *wusername, *password, *protocol, *host, *path, target[1024];
 
-static void write_item(const char *what, WCHAR *wbuf)
+static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 {
 	char *buf;
-	int len = WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, NULL, 0, NULL,
+	int len = WideCharToMultiByte(CP_UTF8, 0, wbuf, wlen, NULL, 0, NULL,
 	    FALSE);
 	buf = xmalloc(len);
 
-	if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, -1, buf, len, NULL, FALSE))
+	if (!WideCharToMultiByte(CP_UTF8, 0, wbuf, wlen, buf, len, NULL, FALSE))
 		die("WideCharToMultiByte failed!");
 
 	printf("%s=", what);
-	fwrite(buf, 1, len - 1, stdout);
+	fwrite(buf, 1, len, stdout);
 	putchar('\n');
 	free(buf);
 }
 
-static int match_attr(const CREDENTIALW *cred, const WCHAR *keyword,
-    const char *want)
+static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
 {
-	int i;
-	if (!want)
-		return 1;
-
-	for (i = 0; i < cred->AttributeCount; ++i)
-		if (!wcscmp(cred->Attributes[i].Keyword, keyword))
-			return !strcmp((const char *)cred->Attributes[i].Value,
-			    want);
-
-	return 0; /* not found */
+	LPCWSTR start = *ptarget;
+	LPCWSTR end = *delim ? wcsstr(start, delim) : start + wcslen(start);
+	int len = end ? end - start : wcslen(start);
+	/* update ptarget if we either found a delimiter or need a match */
+	if (end || want)
+		*ptarget = end ? end + wcslen(delim) : start + len;
+	return !want || (!wcsncmp(want, start, len) && !want[len]);
 }
 
 static int match_cred(const CREDENTIALW *cred)
 {
-	return (!wusername || !wcscmp(wusername, cred->UserName)) &&
-	    match_attr(cred, L"git_protocol", protocol) &&
-	    match_attr(cred, L"git_host", host) &&
-	    match_attr(cred, L"git_path", path);
+	LPCWSTR target = cred->TargetName;
+	if (wusername && wcscmp(wusername, cred->UserName))
+		return 0;
+
+	return match_part(&target, L"git", L":") &&
+		match_part(&target, protocol, L"://") &&
+		match_part(&target, wusername, L"@") &&
+		match_part(&target, host, L"/") &&
+		match_part(&target, path, L"");
 }
 
 static void get_credential(void)
 {
-	WCHAR *user_buf, *pass_buf;
-	DWORD user_buf_size = 0, pass_buf_size = 0;
-	CREDENTIALW **creds, *cred = NULL;
+	CREDENTIALW **creds;
 	DWORD num_creds;
 	int i;
 
@@ -165,44 +143,15 @@ static void get_credential(void)
 	/* search for the first credential that matches username */
 	for (i = 0; i < num_creds; ++i)
 		if (match_cred(creds[i])) {
-			cred = creds[i];
+			write_item("username", creds[i]->UserName,
+				wcslen(creds[i]->UserName));
+			write_item("password",
+				(LPCWSTR)creds[i]->CredentialBlob,
+				creds[i]->CredentialBlobSize / sizeof(WCHAR));
 			break;
 		}
-	if (!cred)
-		return;
-
-	CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
-	    cred->CredentialBlobSize, NULL, &user_buf_size, NULL, NULL,
-	    NULL, &pass_buf_size);
-
-	user_buf = xmalloc(user_buf_size * sizeof(WCHAR));
-	pass_buf = xmalloc(pass_buf_size * sizeof(WCHAR));
-
-	if (!CredUnPackAuthenticationBufferW(0, cred->CredentialBlob,
-	    cred->CredentialBlobSize, user_buf, &user_buf_size, NULL, NULL,
-	    pass_buf, &pass_buf_size))
-		die("CredUnPackAuthenticationBuffer failed");
 
 	CredFree(creds);
-
-	/* zero-terminate (sizes include zero-termination) */
-	user_buf[user_buf_size - 1] = L'\0';
-	pass_buf[pass_buf_size - 1] = L'\0';
-
-	write_item("username", user_buf);
-	write_item("password", pass_buf);
-
-	free(user_buf);
-	free(pass_buf);
-}
-
-static void write_attr(CREDENTIAL_ATTRIBUTEW *attr, const WCHAR *keyword,
-    const char *value)
-{
-	attr->Keyword = (LPWSTR)keyword;
-	attr->Flags = 0;
-	attr->ValueSize = strlen(value) + 1; /* store zero-termination */
-	attr->Value = (LPBYTE)value;
 }
 
 static void store_credential(void)
@@ -215,40 +164,18 @@ static void store_credential(void)
 	if (!wusername || !password)
 		return;
 
-	/* query buffer size */
-	CredPackAuthenticationBufferW(0, wusername, password,
-	    NULL, &auth_buf_size);
-
-	auth_buf = xmalloc(auth_buf_size);
-
-	if (!CredPackAuthenticationBufferW(0, wusername, password,
-	    auth_buf, &auth_buf_size))
-		die("CredPackAuthenticationBuffer failed");
-
 	cred.Flags = 0;
 	cred.Type = CRED_TYPE_GENERIC;
 	cred.TargetName = target;
 	cred.Comment = L"saved by git-credential-wincred";
-	cred.CredentialBlobSize = auth_buf_size;
-	cred.CredentialBlob = auth_buf;
+	cred.CredentialBlobSize = (wcslen(password)) * sizeof(WCHAR);
+	cred.CredentialBlob = (LPVOID)password;
 	cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
-	cred.AttributeCount = 1;
-	cred.Attributes = attrs;
+	cred.AttributeCount = 0;
+	cred.Attributes = NULL;
 	cred.TargetAlias = NULL;
 	cred.UserName = wusername;
 
-	write_attr(attrs, L"git_protocol", protocol);
-
-	if (host) {
-		write_attr(attrs + cred.AttributeCount, L"git_host", host);
-		cred.AttributeCount++;
-	}
-
-	if (path) {
-		write_attr(attrs + cred.AttributeCount, L"git_path", path);
-		cred.AttributeCount++;
-	}
-
 	if (!CredWriteW(&cred, 0))
 		die("CredWrite failed");
 }
@@ -284,10 +211,13 @@ static void read_credential(void)
 
 	while (fgets(buf, sizeof(buf), stdin)) {
 		char *v;
+		int len = strlen(buf);
+		/* strip trailing CR / LF */
+		while (len && strchr("\r\n", buf[len - 1]))
+			buf[--len] = 0;
 
-		if (!strcmp(buf, "\n"))
+		if (!*buf)
 			break;
-		buf[strlen(buf)-1] = '\0';
 
 		v = strchr(buf, '=');
 		if (!v)
@@ -295,13 +225,12 @@ static void read_credential(void)
 		*v++ = '\0';
 
 		if (!strcmp(buf, "protocol"))
-			protocol = xstrdup(v);
+			protocol = utf8_to_utf16_dup(v);
 		else if (!strcmp(buf, "host"))
-			host = xstrdup(v);
+			host = utf8_to_utf16_dup(v);
 		else if (!strcmp(buf, "path"))
-			path = xstrdup(v);
+			path = utf8_to_utf16_dup(v);
 		else if (!strcmp(buf, "username")) {
-			username = xstrdup(v);
 			wusername = utf8_to_utf16_dup(v);
 		} else if (!strcmp(buf, "password"))
 			password = utf8_to_utf16_dup(v);
@@ -330,22 +259,20 @@ int main(int argc, char *argv[])
 		return 0;
 
 	/* prepare 'target', the unique key for the credential */
-	strncat(target_buf, "git:", sizeof(target_buf));
-	strncat(target_buf, protocol, sizeof(target_buf));
-	strncat(target_buf, "://", sizeof(target_buf));
-	if (username) {
-		strncat(target_buf, username, sizeof(target_buf));
-		strncat(target_buf, "@", sizeof(target_buf));
+	wcscpy(target, L"git:");
+	wcsncat(target, protocol, ARRAY_SIZE(target));
+	wcsncat(target, L"://", ARRAY_SIZE(target));
+	if (wusername) {
+		wcsncat(target, wusername, ARRAY_SIZE(target));
+		wcsncat(target, L"@", ARRAY_SIZE(target));
 	}
 	if (host)
-		strncat(target_buf, host, sizeof(target_buf));
+		wcsncat(target, host, ARRAY_SIZE(target));
 	if (path) {
-		strncat(target_buf, "/", sizeof(target_buf));
-		strncat(target_buf, path, sizeof(target_buf));
+		wcsncat(target, L"/", ARRAY_SIZE(target));
+		wcsncat(target, path, ARRAY_SIZE(target));
 	}
 
-	target = utf8_to_utf16_dup(target_buf);
-
 	if (!strcmp(argv[1], "get"))
 		get_credential();
 	else if (!strcmp(argv[1], "store"))
-- 
1.8.0.msysgit.0.4.g4e40dea

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
