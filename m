From: Gisle Aas <gisle.aas@it.uib.no>
Subject: Re: [PATCH] Add --path-prefix option to git-fast-import
Date: Wed, 30 Dec 2009 09:17:39 +0100
Message-ID: <6B75CF25-4EE4-4475-975D-BB1F9A5B8CC2@it.uib.no>
References: <1262091083-25401-1-git-send-email-gisle.aas@it.uib.no> <fabb9a1e0912290606ib1f2e46y1ddbae9aa68e5194@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, gitster@pobox.com, Gisle Aas <gisle@aas.no>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 09:17:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPtkb-0002Nq-3N
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 09:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbZL3IRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 03:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbZL3IRn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 03:17:43 -0500
Received: from alfons.uib.no ([129.177.30.72]:49840 "EHLO alfons.uib.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458AbZL3IRm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 03:17:42 -0500
Received: from thoralf.uib.no (smtp.uib.no) [129.177.13.16] 
	by alfons.uib.no  with esmtp  (Exim 4.69)
	id 1NPtkS-0000Gh-AV; Wed, 30 Dec 2009 09:17:40 +0100
Received: from gala.klientdrift.uib.no [129.177.9.234]:55271 
	by smtp.uib.no  with esmtps (Exim 4.69)
	id 1NPtkS-0006VT-9x; Wed, 30 Dec 2009 09:17:40 +0100
In-Reply-To: <fabb9a1e0912290606ib1f2e46y1ddbae9aa68e5194@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
X-checked-clean: by exiscan on alfons
X-Scanner: d2a14965e0aa1161211a18145a350088 http://tjinfo.uib.no/virus.html
X-UiB-SpamFlag: NO UIB: -24 hits, 8.0 required
X-UiB-SpamReport: spamassassin found;
  -15 From is listed in 'whitelist_SA'
 -9.0 Message received from UIB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135871>

On Dec 29, 2009, at 15:06, Sverre Rabbelier wrote:

> Heya,
> 
> On Tue, Dec 29, 2009 at 06:51, Gisle Aas <gisle.aas@it.uib.no> wrote:
>> +static const char *path_prefix_prepend(struct strbuf *sb, const char *p)
>> +{
>> +       if (p != sb->buf) {
>> +           strbuf_reset(sb);
>> +           strbuf_addstr(sb, p);
>> +       }
>> +       strbuf_insert(sb, 0, path_prefix, path_prefix_len);
>> +       return sb->buf;
>> +}
>> +
>>  static void file_change_m(struct branch *b)
>>  {
>>        const char *p = command_buf.buf + 2;
>> @@ -1909,6 +1921,8 @@ static void file_change_m(struct branch *b)
>>                        die("Garbage after path in: %s", command_buf.buf);
>>                p = uq.buf;
>>        }
>> +       if (path_prefix)
>> +           p = path_prefix_prepend(&uq, p);
> 
> You could reduce the size of this change by having path_prefix_prepend
> check for path_prefix and just do nothing if it is not set.

I felt the explict test was better style -- more obvious that nothing happens to p
when there is no path_prefix.

--Gisle