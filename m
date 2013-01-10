From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 2/2] wincred: improve compatibility with windows versions
Date: Thu, 10 Jan 2013 13:10:25 +0100
Message-ID: <50EEAFB1.2090604@gmail.com>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com> <50EC473A.6060203@gmail.com> <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, msysgit@googlegroups.com, 
 Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: msysgit+bncBCH3XYXLXQDBBMW7XKDQKGQEEGSONVY@googlegroups.com Thu Jan 10 13:10:45 2013
Return-path: <msysgit+bncBCH3XYXLXQDBBMW7XKDQKGQEEGSONVY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBMW7XKDQKGQEEGSONVY@googlegroups.com>)
	id 1TtGy2-0001h1-Tn
	for gcvm-msysgit@m.gmane.org; Thu, 10 Jan 2013 13:10:42 +0100
Received: by mail-wi0-f188.google.com with SMTP id hn3sf219260wib.25
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Jan 2013 04:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=LvQ9ubEQsUYSokuW8ILVyqU3dBlq0ZryjY5uM3pFTWA=;
        b=zVgPVEehxti47Y1ZGB6EbgevwoNeE6sLzIYYBHE2rVeW6amImFtZk/cc6c8fVTDFFC
         qu1MIw41A7LycYm0GfW9V9aOXgWNYzm9N6BttBfR21+VPnp0vS4s7pY3K/nvnbOqV8HS
         22wUafMl8OasM1XXk7rReo/FBxbkjcmuJ8/dH5fSQf/28nY8o8dcwvZ7UVkUr/hoaAKC
         EldAaZamZYgs8L5VG/uW+IPtB4XE3e+me4TJtlyt5a+8LCfDe2ZqWSNp8qV2GV8YuLzt
         mer0bmJz0JU+N2Pyr9lXQ 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=LvQ9ubEQsUYSokuW8ILVyqU3dBlq0ZryjY5uM3pFTWA=;
        b=D0Uk9xsmGCDB/MrFmYIkQpkUM9JxFN4dZz6Jof9hmj5m0d5HxLOzdi8UOdTeSW9tTf
         ib7g50Haw7134eql0EhsPwQI+PIYCAk9EEGjRVD++DLwK0QVbtql+H81aaMTQ91JiUIS
         tdbz1n4yJbBKcYRB0tWCxESlXTuZHizyIcROReOW9hMS6VhVuXZHTC/h1OMFcTnGjizX
         qmwzeBHZbWyvC78sPrIThIHejanoWUCpzkR0gGRKluk00TaBDwptgvTTHpAP3EmHOo29
         4P/Gvcq8jPCMYjVKvBqqlCEu37rY 
X-Received: by 10.180.90.107 with SMTP id bv11mr1245831wib.0.1357819827222;
        Thu, 10 Jan 2013 04:10:27 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.11.136 with SMTP id ei8ls1550610wid.11.gmail; Thu, 10 Jan
 2013 04:10:26 -0800 (PST)
X-Received: by 10.204.130.141 with SMTP id t13mr3549632bks.3.1357819826352;
        Thu, 10 Jan 2013 04:10:26 -0800 (PST)
X-Received: by 10.204.130.141 with SMTP id t13mr3549631bks.3.1357819826326;
        Thu, 10 Jan 2013 04:10:26 -0800 (PST)
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com [209.85.217.181])
        by gmr-mx.google.com with ESMTPS id j28si127133bkv.0.2013.01.10.04.10.26
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 04:10:26 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 209.85.217.181 as permitted sender) client-ip=209.85.217.181;
Received: by mail-lb0-f181.google.com with SMTP id ge1so423337lbb.12
        for <msysgit@googlegroups.com>; Thu, 10 Jan 2013 04:10:26 -0800 (PST)
X-Received: by 10.112.50.138 with SMTP id c10mr29236964lbo.104.1357819825923;
        Thu, 10 Jan 2013 04:10:25 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id ee5sm699630lbb.14.2013.01.10.04.10.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 04:10:25 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 209.85.217.181 as
 permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213140>

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

Credentials created with an old wincred version will have mangled or empty
passwords after this change.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 .../credential/wincred/git-credential-wincred.c    | 199 ++++++++-------------
 1 file changed, 70 insertions(+), 129 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 94d7140..dac19ea 100644
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
 
-static HMODULE advapi, credui;
+static HMODULE advapi;
 static CredWriteWT CredWriteW;
-static CredUnPackAuthenticationBufferWT CredUnPackAuthenticationBufferW;
 static CredEnumerateWT CredEnumerateW;
-static CredPackAuthenticationBufferWT CredPackAuthenticationBufferW;
 static CredFreeT CredFree;
 static CredDeleteWT CredDeleteW;
 
@@ -88,74 +76,84 @@ static void load_cred_funcs(void)
 {
 	/* load DLLs */
 	advapi = LoadLibrary("advapi32.dll");
-	credui = LoadLibrary("credui.dll");
-	if (!advapi || !credui)
-		die("failed to load DLLs");
+	if (!advapi)
+		die("failed to load advapi32.dll");
 
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
+/*
+ * Match an (optional) expected string and a delimiter in the target string,
+ * consuming the matched text by updating the target pointer.
+ */
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
+	LPCWSTR delim_pos, start = *ptarget;
+	int len;
+
+	/* find start of delimiter (or end-of-string if delim is empty) */
+	if (*delim)
+		delim_pos = wcsstr(start, delim);
+	else
+		delim_pos = start + wcslen(start);
+
+	/*
+	 * match text up to delimiter, or end of string (e.g. the '/' after
+	 * host is optional if not followed by a path)
+	 */
+	if (delim_pos)
+		len = delim_pos - start;
+	else
+		len = wcslen(start);
+
+	/* update ptarget if we either found a delimiter or need a match */
+	if (delim_pos || want)
+		*ptarget = delim_pos ? delim_pos + wcslen(delim) : start + len;
+
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
 
@@ -165,90 +163,36 @@ static void get_credential(void)
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
 {
 	CREDENTIALW cred;
-	BYTE *auth_buf;
-	DWORD auth_buf_size = 0;
-	CREDENTIAL_ATTRIBUTEW attrs[CRED_MAX_ATTRIBUTES];
 
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
@@ -298,13 +242,12 @@ static void read_credential(void)
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
@@ -333,22 +276,20 @@ int main(int argc, char *argv[])
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
