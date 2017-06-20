Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894FA20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbdFTH5v (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32774 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdFTH4R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id f90so21269678wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SDzRxrgW8tWsHbggt1IcXQ5uB/6tGkfC+vaCMGmGTmA=;
        b=e4glD3vB90ljUzf9hPk++ZCd6H+nPSqsNTuEkDdfONjJ0H9AQI6WgswhWRNpP8eytn
         nWlC+Ycq6pAbRCjOXWnFyDikK/DMuh5+9mrBchmXGVgWS+HrgDxqPqqkTdfKwTNTgn02
         YKy/9Gxkvj3sFb5zSNUCvghG/tLTLWtgwpfl/iSCVtxO/ppnKxehC0TRgFHlI8h2KfXu
         v23CxK6cg5JIJcv7SzJ21KRG4SxJIW+zZB/ZQ4qqFH2dfDPi5a1jiFl8FqtnmUF8ViDE
         9OjSmlnsPpwmFsEbdbf84H7Y1O9+2dVZ5nl8uIHKLEHdJ9bI07OUadU/5fWj1UVdMlLC
         jLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SDzRxrgW8tWsHbggt1IcXQ5uB/6tGkfC+vaCMGmGTmA=;
        b=miecFDPTZKrMBsR4tZGs3g9+Pqv55mieZihpzLdtPqudvl28RW5fnvv8ecHMzwTdYK
         bl1L2/qY3JJ3z5G0Y1Rn+/7DOA99vWhIpiBcdFlcRbaGvLNpREuZbMx5RRumhqUJmdzz
         ws44v2+t+niaRJm4kuvEA7y2m0ukUClZGyi8Ofs4tEwfDpPHkwKIilELgw651ZpVI1Y7
         Z0muFtZQmVlGfzybhWn4ym1dGU5R4u6g4eLE8pg2tauZLjIpty1y/YJPbyRBcXx0xXOD
         pml7lkmYLMf7ApWlxt8nRgyuBVxbAAwf/hG+sbhqJDUrsqYv5UlMdz4c+ExgpMwMGtV0
         VjNw==
X-Gm-Message-State: AKS2vOxTV+sQOE4SA0KJJxZGg6mF7n6sJgGE+9ndHxyIQLho3trxSI6l
        aPy31z4Ws666YHDd
X-Received: by 10.28.189.67 with SMTP id n64mr1724786wmf.115.1497945375606;
        Tue, 20 Jun 2017 00:56:15 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:14 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 20/49] lib-httpd: add apache-e-odb.conf
Date:   Tue, 20 Jun 2017 09:54:54 +0200
Message-Id: <20170620075523.26961-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an apache config file to test external object databases.
It uses the upload.sh and list.sh cgi that have been added
previously to make apache store external objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd/apache-e-odb.conf | 214 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 t/lib-httpd/apache-e-odb.conf

diff --git a/t/lib-httpd/apache-e-odb.conf b/t/lib-httpd/apache-e-odb.conf
new file mode 100644
index 0000000000..19a1540c82
--- /dev/null
+++ b/t/lib-httpd/apache-e-odb.conf
@@ -0,0 +1,214 @@
+ServerName dummy
+PidFile httpd.pid
+DocumentRoot www
+LogFormat "%h %l %u %t \"%r\" %>s %b" common
+CustomLog access.log common
+ErrorLog error.log
+<IfModule !mod_log_config.c>
+	LoadModule log_config_module modules/mod_log_config.so
+</IfModule>
+<IfModule !mod_alias.c>
+	LoadModule alias_module modules/mod_alias.so
+</IfModule>
+<IfModule !mod_cgi.c>
+	LoadModule cgi_module modules/mod_cgi.so
+</IfModule>
+<IfModule !mod_env.c>
+	LoadModule env_module modules/mod_env.so
+</IfModule>
+<IfModule !mod_rewrite.c>
+	LoadModule rewrite_module modules/mod_rewrite.so
+</IFModule>
+<IfModule !mod_version.c>
+	LoadModule version_module modules/mod_version.so
+</IfModule>
+<IfModule !mod_headers.c>
+	LoadModule headers_module modules/mod_headers.so
+</IfModule>
+
+<IfVersion < 2.4>
+LockFile accept.lock
+</IfVersion>
+
+<IfVersion < 2.1>
+<IfModule !mod_auth.c>
+	LoadModule auth_module modules/mod_auth.so
+</IfModule>
+</IfVersion>
+
+<IfVersion >= 2.1>
+<IfModule !mod_auth_basic.c>
+	LoadModule auth_basic_module modules/mod_auth_basic.so
+</IfModule>
+<IfModule !mod_authn_file.c>
+	LoadModule authn_file_module modules/mod_authn_file.so
+</IfModule>
+<IfModule !mod_authz_user.c>
+	LoadModule authz_user_module modules/mod_authz_user.so
+</IfModule>
+<IfModule !mod_authz_host.c>
+	LoadModule authz_host_module modules/mod_authz_host.so
+</IfModule>
+</IfVersion>
+
+<IfVersion >= 2.4>
+<IfModule !mod_authn_core.c>
+	LoadModule authn_core_module modules/mod_authn_core.so
+</IfModule>
+<IfModule !mod_authz_core.c>
+	LoadModule authz_core_module modules/mod_authz_core.so
+</IfModule>
+<IfModule !mod_access_compat.c>
+	LoadModule access_compat_module modules/mod_access_compat.so
+</IfModule>
+<IfModule !mod_mpm_prefork.c>
+	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
+</IfModule>
+<IfModule !mod_unixd.c>
+	LoadModule unixd_module modules/mod_unixd.so
+</IfModule>
+</IfVersion>
+
+PassEnv GIT_VALGRIND
+PassEnv GIT_VALGRIND_OPTIONS
+PassEnv GNUPGHOME
+PassEnv ASAN_OPTIONS
+PassEnv GIT_TRACE
+PassEnv GIT_CONFIG_NOSYSTEM
+
+Alias /dumb/ www/
+Alias /auth/dumb/ www/auth/dumb/
+
+<LocationMatch /smart/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
+<LocationMatch /smart_noexport/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+</LocationMatch>
+<LocationMatch /smart_custom_env/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	SetEnv GIT_COMMITTER_NAME "Custom User"
+	SetEnv GIT_COMMITTER_EMAIL custom@example.com
+</LocationMatch>
+<LocationMatch /smart_namespace/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	SetEnv GIT_NAMESPACE ns
+</LocationMatch>
+<LocationMatch /smart_cookies/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+	Header set Set-Cookie name=value
+</LocationMatch>
+<LocationMatch /smart_headers/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
+ScriptAlias /upload/ upload.sh/
+ScriptAlias /list/ list.sh/
+<Directory ${GIT_EXEC_PATH}>
+	Options FollowSymlinks
+</Directory>
+<Files upload.sh>
+  Options ExecCGI
+</Files>
+<Files list.sh>
+  Options ExecCGI
+</Files>
+<Files ${GIT_EXEC_PATH}/git-http-backend>
+	Options ExecCGI
+</Files>
+
+RewriteEngine on
+RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
+RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
+RewriteRule ^/smart-redir-auth/(.*)$ /auth/smart/$1 [R=301]
+RewriteRule ^/smart-redir-limited/(.*)/info/refs$ /smart/$1/info/refs [R=301]
+RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
+
+RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
+RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
+
+# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
+# And as RewriteCond does not allow testing for non-matches, we match
+# the desired case first (one has abra, two has cadabra), and let it
+# pass by marking the RewriteRule as [L], "last rule, do not process
+# any other matching RewriteRules after this"), and then have another
+# RewriteRule that matches all other cases and lets them fail via '[F]',
+# "fail the request".
+RewriteCond %{HTTP:x-magic-one} =abra
+RewriteCond %{HTTP:x-magic-two} =cadabra
+RewriteRule ^/smart_headers/.* - [L]
+RewriteRule ^/smart_headers/.* - [F]
+
+<IfDefine SSL>
+LoadModule ssl_module modules/mod_ssl.so
+
+SSLCertificateFile httpd.pem
+SSLCertificateKeyFile httpd.pem
+SSLRandomSeed startup file:/dev/urandom 512
+SSLRandomSeed connect file:/dev/urandom 512
+SSLSessionCache none
+SSLMutex file:ssl_mutex
+SSLEngine On
+</IfDefine>
+
+<Location /auth/>
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</Location>
+
+<LocationMatch "^/auth-push/.*/git-receive-pack$">
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</LocationMatch>
+
+<LocationMatch "^/auth-fetch/.*/git-upload-pack$">
+	AuthType Basic
+	AuthName "git-auth"
+	AuthUserFile passwd
+	Require valid-user
+</LocationMatch>
+
+RewriteCond %{QUERY_STRING} service=git-receive-pack [OR]
+RewriteCond %{REQUEST_URI} /git-receive-pack$
+RewriteRule ^/half-auth-complete/ - [E=AUTHREQUIRED:yes]
+
+<Location /half-auth-complete/>
+  Order Deny,Allow
+  Deny from env=AUTHREQUIRED
+
+  AuthType Basic
+  AuthName "Git Access"
+  AuthUserFile passwd
+  Require valid-user
+  Satisfy Any
+</Location>
+
+<IfDefine DAV>
+	LoadModule dav_module modules/mod_dav.so
+	LoadModule dav_fs_module modules/mod_dav_fs.so
+
+	DAVLockDB DAVLock
+	<Location /dumb/>
+		Dav on
+	</Location>
+	<Location /auth/dumb>
+		Dav on
+	</Location>
+</IfDefine>
+
+<IfDefine SVN>
+	LoadModule dav_svn_module modules/mod_dav_svn.so
+
+	<Location /${LIB_HTTPD_SVN}>
+		DAV svn
+		SVNPath "${LIB_HTTPD_SVNPATH}"
+	</Location>
+</IfDefine>
-- 
2.13.1.565.gbfcd7a9048

