Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B719FA91
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815481; cv=none; b=k+ECoqfbKqcxPkqk4LHPE7L8QTd+8mroqHi3hb/v1RVvF63qF/jCtkUmTtznjTSVnBGGxbbFpdpzWqeI8WOIk8i7hJyeQbzWL6clIt+Dz9zPVtheEN5pEOWT3XoL0AydxWnPTAGLopRoryYPGDjtN+cTICBuqpNX9q6KvDVsrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815481; c=relaxed/simple;
	bh=PH1HI0h/gQe24loNRFbiaEzEPdr7GC8ljEPfYeWVTvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dj4ulBliD0PQWddH6dpZRUBMzPHIaaqQLfqR/mz5aqkrcT6KUkN/TMLzTzBUI7OViU5mgTFTWUBXsMG/zlwMcYU/XwAWoAkYSnoOU1pc1n3rPd67wD8rI6IOnRlSM8dZbtrueDcWla7Ig0/CLXD3TJWw4Baum/s8Sims50tj9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gar+uuT/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gar+uuT/"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso865265f8f.0
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723815475; x=1724420275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6SwJpGkHIC0XbGg6XwH+5/YVx+HP9Sp0JR7FWLHPlZY=;
        b=gar+uuT/2L7DNIOOkcgmoaM4Oq1somjYYfptdRDgXW8XXyp7cJpdYFSQqAk9atmyiB
         xrLPhkdQ3z6+cuwF9ajetom3RpvOKG6tn1skLOTpjslM6fMMso3bjjNXxpZNY44sIbSz
         pvWJPHqHs4EAnV/36Usd8BTZgRX3UzTzrRFufpVvPK2TBSa+l6B7YxFXq1pXc9Dq7Ht6
         9UcnQi93yQz/LEdpVycm0GkD5hnKB9XqM+Vr/GaZAVYe9huKfNV0FlCqVqElYr/ue9mm
         wdWB/73+rihwoCByOCkAVSvcW6L9gx5+RNgaMxDJklbApCAogkLFYCz88c09UgvRMvIJ
         KZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815475; x=1724420275;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SwJpGkHIC0XbGg6XwH+5/YVx+HP9Sp0JR7FWLHPlZY=;
        b=VlBRqHBKZcY8e+3U5FQy8PQzr3N0rF8Be0RKl5HkBSut7Dz2yo1GxD6f/s1A7svk1p
         gzQGqFv4mFlMDvAywl6ovYAvSc8eml9XboT/6U0tPqlshW08sm+zphOsfBAgYEGUk7ww
         q4Dg4DoMJXA7qoWaMSfAUFs+tLez0jyMHK4jW/ePZ2pEVOlvIu4OAikVZN501ps7VJOk
         GLnVCpIa4MqsvzJR18pSDz5CdOS22TxK+pVXo931IYwdeJGIaNan0Ed/HW3ThHa92Vaz
         57MgXioCzUBsoT73k2MwaiCdFTwIlUaSu0/pUYWoNjEaS5Qn79D4nRNEF3HlvD04iwZo
         CVSw==
X-Forwarded-Encrypted: i=1; AJvYcCWDW0v8vE6mmNZy+M3wd+FglgI/6gb/TPNeQp6PCW+iz7ulZydKKsQ1iKg/SknZDviQCMGgsGerFagJuibrUnBk90qP
X-Gm-Message-State: AOJu0YzbmhjlSdoxQb6uRCVj35BAIINpA8eGbwInuMd2wchsXRHaauBV
	QhJznY50wrXwNN1Si7CqQ4FbPsMN9nT7D30gqLR/fLAKPK06rMaw
X-Google-Smtp-Source: AGHT+IFV3dje8Wk1s1dkgqYvxm6w5G24D0qCBdVVK6W8R7NAlvmTTeKXz5v71y9XdSqqI4zw0mcl9Q==
X-Received: by 2002:a5d:4d48:0:b0:367:8f81:f9fc with SMTP id ffacd0b85a97d-371946a98e3mr1892092f8f.50.1723815473906;
        Fri, 16 Aug 2024 06:37:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898b89bdsm3651414f8f.112.2024.08.16.06.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 06:37:53 -0700 (PDT)
Message-ID: <831543c6-2282-44f7-bf05-b66c2d6b08cc@gmail.com>
Date: Fri, 16 Aug 2024 14:37:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 2/9] t: import the clar unit testing framework
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
 <369060793306daab1796ae3063b4eaacc287f12d.1723791831.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <369060793306daab1796ae3063b4eaacc287f12d.1723791831.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Johannes - are these format specifiers supported by the version of 
MSVCRT that is used by git for windows? c.f. 
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2203241456250.388@tvgsbejvaqbjf.bet/

On 16/08/2024 08:04, Patrick Steinhardt wrote:
> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
> [...]
> +#ifdef _WIN32
 > [...]
> +#	ifndef PRIuZ
> +#		define PRIuZ "Iu"
> +#	endif
> +#	ifndef PRIxZ
> +#		define PRIxZ "Ix"
> +#	endif

Thanks

Phillip

> +#	if defined(_MSC_VER) || defined(__MINGW32__)
> +	typedef struct stat STAT_T;
> +#	else
> +	typedef struct _stat STAT_T;
> +#	endif
> +#else
> +#	include <sys/wait.h> /* waitpid(2) */
> +#	include <unistd.h>
> +#	define _MAIN_CC
> +#	define p_snprintf snprintf
> +#	ifndef PRIuZ
> +#		define PRIuZ "zu"
> +#	endif
> +#	ifndef PRIxZ
> +#		define PRIxZ "zx"
> +#	endif
> +	typedef struct stat STAT_T;
> +#endif
> +
> +#define MAX(x, y) (((x) > (y)) ? (x) : (y))
> +
> +#include "clar.h"
> +
> +static void fs_rm(const char *_source);
> +static void fs_copy(const char *_source, const char *dest);
> +
> +#ifdef CLAR_FIXTURE_PATH
> +static const char *
> +fixture_path(const char *base, const char *fixture_name);
> +#endif
> +
> +struct clar_error {
> +	const char *file;
> +	const char *function;
> +	size_t line_number;
> +	const char *error_msg;
> +	char *description;
> +
> +	struct clar_error *next;
> +};
> +
> +struct clar_explicit {
> +	size_t suite_idx;
> +	const char *filter;
> +
> +	struct clar_explicit *next;
> +};
> +
> +struct clar_report {
> +	const char *test;
> +	int test_number;
> +	const char *suite;
> +
> +	enum cl_test_status status;
> +	time_t start;
> +	double elapsed;
> +
> +	struct clar_error *errors;
> +	struct clar_error *last_error;
> +
> +	struct clar_report *next;
> +};
> +
> +struct clar_summary {
> +	const char *filename;
> +	FILE *fp;
> +};
> +
> +static struct {
> +	enum cl_test_status test_status;
> +
> +	const char *active_test;
> +	const char *active_suite;
> +
> +	int total_skipped;
> +	int total_errors;
> +
> +	int tests_ran;
> +	int suites_ran;
> +
> +	enum cl_output_format output_format;
> +
> +	int report_errors_only;
> +	int exit_on_error;
> +	int verbosity;
> +
> +	int write_summary;
> +	char *summary_filename;
> +	struct clar_summary *summary;
> +
> +	struct clar_explicit *explicit;
> +	struct clar_explicit *last_explicit;
> +
> +	struct clar_report *reports;
> +	struct clar_report *last_report;
> +
> +	void (*local_cleanup)(void *);
> +	void *local_cleanup_payload;
> +
> +	jmp_buf trampoline;
> +	int trampoline_enabled;
> +
> +	cl_trace_cb *pfn_trace_cb;
> +	void *trace_payload;
> +
> +} _clar;
> +
> +struct clar_func {
> +	const char *name;
> +	void (*ptr)(void);
> +};
> +
> +struct clar_suite {
> +	const char *name;
> +	struct clar_func initialize;
> +	struct clar_func cleanup;
> +	const struct clar_func *tests;
> +	size_t test_count;
> +	int enabled;
> +};
> +
> +/* From clar_print_*.c */
> +static void clar_print_init(int test_count, int suite_count, const char *suite_names);
> +static void clar_print_shutdown(int test_count, int suite_count, int error_count);
> +static void clar_print_error(int num, const struct clar_report *report, const struct clar_error *error);
> +static void clar_print_ontest(const char *suite_name, const char *test_name, int test_number, enum cl_test_status failed);
> +static void clar_print_onsuite(const char *suite_name, int suite_index);
> +static void clar_print_onabort(const char *msg, ...);
> +
> +/* From clar_sandbox.c */
> +static void clar_unsandbox(void);
> +static int clar_sandbox(void);
> +
> +/* From summary.h */
> +static struct clar_summary *clar_summary_init(const char *filename);
> +static int clar_summary_shutdown(struct clar_summary *fp);
> +
> +/* Load the declarations for the test suite */
> +#include "clar.suite"
> +
> +
> +#define CL_TRACE(ev)													\
> +	do {																\
> +		if (_clar.pfn_trace_cb)											\
> +			_clar.pfn_trace_cb(ev,										\
> +							   _clar.active_suite,						\
> +							   _clar.active_test,						\
> +							   _clar.trace_payload);					\
> +	} while (0)
> +
> +void cl_trace_register(cl_trace_cb *cb, void *payload)
> +{
> +	_clar.pfn_trace_cb = cb;
> +	_clar.trace_payload = payload;
> +}
> +
> +
> +/* Core test functions */
> +static void
> +clar_report_errors(struct clar_report *report)
> +{
> +	struct clar_error *error;
> +	int i = 1;
> +
> +	for (error = report->errors; error; error = error->next)
> +		clar_print_error(i++, _clar.last_report, error);
> +}
> +
> +static void
> +clar_report_all(void)
> +{
> +	struct clar_report *report;
> +	struct clar_error *error;
> +	int i = 1;
> +
> +	for (report = _clar.reports; report; report = report->next) {
> +		if (report->status != CL_TEST_FAILURE)
> +			continue;
> +
> +		for (error = report->errors; error; error = error->next)
> +			clar_print_error(i++, report, error);
> +	}
> +}
> +
> +#ifdef WIN32
> +# define clar_time DWORD
> +
> +static void clar_time_now(clar_time *out)
> +{
> +	*out = GetTickCount();
> +}
> +
> +static double clar_time_diff(clar_time *start, clar_time *end)
> +{
> +	return ((double)*end - (double)*start) / 1000;
> +}
> +#else
> +# include <sys/time.h>
> +
> +# define clar_time struct timeval
> +
> +static void clar_time_now(clar_time *out)
> +{
> +	struct timezone tz;
> +
> +	gettimeofday(out, &tz);
> +}
> +
> +static double clar_time_diff(clar_time *start, clar_time *end)
> +{
> +	return ((double)end->tv_sec + (double)end->tv_usec / 1.0E6) -
> +	       ((double)start->tv_sec + (double)start->tv_usec / 1.0E6);
> +}
> +#endif
> +
> +static void
> +clar_run_test(
> +	const struct clar_suite *suite,
> +	const struct clar_func *test,
> +	const struct clar_func *initialize,
> +	const struct clar_func *cleanup)
> +{
> +	clar_time start, end;
> +
> +	_clar.trampoline_enabled = 1;
> +
> +	CL_TRACE(CL_TRACE__TEST__BEGIN);
> +
> +	_clar.last_report->start = time(NULL);
> +	clar_time_now(&start);
> +
> +	if (setjmp(_clar.trampoline) == 0) {
> +		if (initialize->ptr != NULL)
> +			initialize->ptr();
> +
> +		CL_TRACE(CL_TRACE__TEST__RUN_BEGIN);
> +		test->ptr();
> +		CL_TRACE(CL_TRACE__TEST__RUN_END);
> +	}
> +
> +	clar_time_now(&end);
> +
> +	_clar.trampoline_enabled = 0;
> +
> +	if (_clar.last_report->status == CL_TEST_NOTRUN)
> +		_clar.last_report->status = CL_TEST_OK;
> +
> +	_clar.last_report->elapsed = clar_time_diff(&start, &end);
> +
> +	if (_clar.local_cleanup != NULL)
> +		_clar.local_cleanup(_clar.local_cleanup_payload);
> +
> +	if (cleanup->ptr != NULL)
> +		cleanup->ptr();
> +
> +	CL_TRACE(CL_TRACE__TEST__END);
> +
> +	_clar.tests_ran++;
> +
> +	/* remove any local-set cleanup methods */
> +	_clar.local_cleanup = NULL;
> +	_clar.local_cleanup_payload = NULL;
> +
> +	if (_clar.report_errors_only) {
> +		clar_report_errors(_clar.last_report);
> +	} else {
> +		clar_print_ontest(suite->name, test->name, _clar.tests_ran, _clar.last_report->status);
> +	}
> +}
> +
> +static void
> +clar_run_suite(const struct clar_suite *suite, const char *filter)
> +{
> +	const struct clar_func *test = suite->tests;
> +	size_t i, matchlen;
> +	struct clar_report *report;
> +	int exact = 0;
> +
> +	if (!suite->enabled)
> +		return;
> +
> +	if (_clar.exit_on_error && _clar.total_errors)
> +		return;
> +
> +	if (!_clar.report_errors_only)
> +		clar_print_onsuite(suite->name, ++_clar.suites_ran);
> +
> +	_clar.active_suite = suite->name;
> +	_clar.active_test = NULL;
> +	CL_TRACE(CL_TRACE__SUITE_BEGIN);
> +
> +	if (filter) {
> +		size_t suitelen = strlen(suite->name);
> +		matchlen = strlen(filter);
> +		if (matchlen <= suitelen) {
> +			filter = NULL;
> +		} else {
> +			filter += suitelen;
> +			while (*filter == ':')
> +				++filter;
> +			matchlen = strlen(filter);
> +
> +			if (matchlen && filter[matchlen - 1] == '$') {
> +				exact = 1;
> +				matchlen--;
> +			}
> +		}
> +	}
> +
> +	for (i = 0; i < suite->test_count; ++i) {
> +		if (filter && strncmp(test[i].name, filter, matchlen))
> +			continue;
> +
> +		if (exact && strlen(test[i].name) != matchlen)
> +			continue;
> +
> +		_clar.active_test = test[i].name;
> +
> +		report = calloc(1, sizeof(struct clar_report));
> +		report->suite = _clar.active_suite;
> +		report->test = _clar.active_test;
> +		report->test_number = _clar.tests_ran;
> +		report->status = CL_TEST_NOTRUN;
> +
> +		if (_clar.reports == NULL)
> +			_clar.reports = report;
> +
> +		if (_clar.last_report != NULL)
> +			_clar.last_report->next = report;
> +
> +		_clar.last_report = report;
> +
> +		clar_run_test(suite, &test[i], &suite->initialize, &suite->cleanup);
> +
> +		if (_clar.exit_on_error && _clar.total_errors)
> +			return;
> +	}
> +
> +	_clar.active_test = NULL;
> +	CL_TRACE(CL_TRACE__SUITE_END);
> +}
> +
> +static void
> +clar_usage(const char *arg)
> +{
> +	printf("Usage: %s [options]\n\n", arg);
> +	printf("Options:\n");
> +	printf("  -sname        Run only the suite with `name` (can go to individual test name)\n");
> +	printf("  -iname        Include the suite with `name`\n");
> +	printf("  -xname        Exclude the suite with `name`\n");
> +	printf("  -v            Increase verbosity (show suite names)\n");
> +	printf("  -q            Only report tests that had an error\n");
> +	printf("  -Q            Quit as soon as a test fails\n");
> +	printf("  -t            Display results in tap format\n");
> +	printf("  -l            Print suite names\n");
> +	printf("  -r[filename]  Write summary file (to the optional filename)\n");
> +	exit(-1);
> +}
> +
> +static void
> +clar_parse_args(int argc, char **argv)
> +{
> +	int i;
> +
> +	/* Verify options before execute */
> +	for (i = 1; i < argc; ++i) {
> +		char *argument = argv[i];
> +
> +		if (argument[0] != '-' || argument[1] == '\0'
> +		    || strchr("sixvqQtlr", argument[1]) == NULL) {
> +			clar_usage(argv[0]);
> +		}
> +	}
> +
> +	for (i = 1; i < argc; ++i) {
> +		char *argument = argv[i];
> +
> +		switch (argument[1]) {
> +		case 's':
> +		case 'i':
> +		case 'x': { /* given suite name */
> +			int offset = (argument[2] == '=') ? 3 : 2, found = 0;
> +			char action = argument[1];
> +			size_t j, arglen, suitelen, cmplen;
> +
> +			argument += offset;
> +			arglen = strlen(argument);
> +
> +			if (arglen == 0)
> +				clar_usage(argv[0]);
> +
> +			for (j = 0; j < _clar_suite_count; ++j) {
> +				suitelen = strlen(_clar_suites[j].name);
> +				cmplen = (arglen < suitelen) ? arglen : suitelen;
> +
> +				if (strncmp(argument, _clar_suites[j].name, cmplen) == 0) {
> +					int exact = (arglen >= suitelen);
> +
> +					/* Do we have a real suite prefix separated by a
> +					 * trailing '::' or just a matching substring? */
> +					if (arglen > suitelen && (argument[suitelen] != ':'
> +						    || argument[suitelen + 1] != ':'))
> +					    continue;
> +
> +					++found;
> +
> +					if (!exact)
> +						_clar.verbosity = MAX(_clar.verbosity, 1);
> +
> +					switch (action) {
> +					case 's': {
> +						struct clar_explicit *explicit =
> +							calloc(1, sizeof(struct clar_explicit));
> +						assert(explicit);
> +
> +						explicit->suite_idx = j;
> +						explicit->filter = argument;
> +
> +						if (_clar.explicit == NULL)
> +							_clar.explicit = explicit;
> +
> +						if (_clar.last_explicit != NULL)
> +							_clar.last_explicit->next = explicit;
> +
> +						_clar_suites[j].enabled = 1;
> +						_clar.last_explicit = explicit;
> +						break;
> +					}
> +					case 'i': _clar_suites[j].enabled = 1; break;
> +					case 'x': _clar_suites[j].enabled = 0; break;
> +					}
> +
> +					if (exact)
> +						break;
> +				}
> +			}
> +
> +			if (!found) {
> +				clar_print_onabort("No suite matching '%s' found.\n", argument);
> +				exit(-1);
> +			}
> +			break;
> +		}
> +
> +		case 'q':
> +			_clar.report_errors_only = 1;
> +			break;
> +
> +		case 'Q':
> +			_clar.exit_on_error = 1;
> +			break;
> +
> +		case 't':
> +			_clar.output_format = CL_OUTPUT_TAP;
> +			break;
> +
> +		case 'l': {
> +			size_t j;
> +			printf("Test suites (use -s<name> to run just one):\n");
> +			for (j = 0; j < _clar_suite_count; ++j)
> +				printf(" %3d: %s\n", (int)j, _clar_suites[j].name);
> +
> +			exit(0);
> +		}
> +
> +		case 'v':
> +			_clar.verbosity++;
> +			break;
> +
> +		case 'r':
> +			_clar.write_summary = 1;
> +			free(_clar.summary_filename);
> +			_clar.summary_filename = *(argument + 2) ? strdup(argument + 2) : NULL;
> +			break;
> +
> +		default:
> +			assert(!"Unexpected commandline argument!");
> +		}
> +	}
> +}
> +
> +void
> +clar_test_init(int argc, char **argv)
> +{
> +	const char *summary_env;
> +
> +	if (argc > 1)
> +		clar_parse_args(argc, argv);
> +
> +	clar_print_init(
> +		(int)_clar_callback_count,
> +		(int)_clar_suite_count,
> +		""
> +	);
> +
> +	if (!_clar.summary_filename &&
> +	    (summary_env = getenv("CLAR_SUMMARY")) != NULL) {
> +		_clar.write_summary = 1;
> +		_clar.summary_filename = strdup(summary_env);
> +	}
> +
> +	if (_clar.write_summary && !_clar.summary_filename)
> +		_clar.summary_filename = strdup("summary.xml");
> +
> +	if (_clar.write_summary &&
> +	    !(_clar.summary = clar_summary_init(_clar.summary_filename))) {
> +		clar_print_onabort("Failed to open the summary file\n");
> +		exit(-1);
> +	}
> +
> +	if (clar_sandbox() < 0) {
> +		clar_print_onabort("Failed to sandbox the test runner.\n");
> +		exit(-1);
> +	}
> +}
> +
> +int
> +clar_test_run(void)
> +{
> +	size_t i;
> +	struct clar_explicit *explicit;
> +
> +	if (_clar.explicit) {
> +		for (explicit = _clar.explicit; explicit; explicit = explicit->next)
> +			clar_run_suite(&_clar_suites[explicit->suite_idx], explicit->filter);
> +	} else {
> +		for (i = 0; i < _clar_suite_count; ++i)
> +			clar_run_suite(&_clar_suites[i], NULL);
> +	}
> +
> +	return _clar.total_errors;
> +}
> +
> +void
> +clar_test_shutdown(void)
> +{
> +	struct clar_explicit *explicit, *explicit_next;
> +	struct clar_report *report, *report_next;
> +
> +	clar_print_shutdown(
> +		_clar.tests_ran,
> +		(int)_clar_suite_count,
> +		_clar.total_errors
> +	);
> +
> +	clar_unsandbox();
> +
> +	if (_clar.write_summary && clar_summary_shutdown(_clar.summary) < 0) {
> +		clar_print_onabort("Failed to write the summary file\n");
> +		exit(-1);
> +	}
> +
> +	for (explicit = _clar.explicit; explicit; explicit = explicit_next) {
> +		explicit_next = explicit->next;
> +		free(explicit);
> +	}
> +
> +	for (report = _clar.reports; report; report = report_next) {
> +		report_next = report->next;
> +		free(report);
> +	}
> +
> +	free(_clar.summary_filename);
> +}
> +
> +int
> +clar_test(int argc, char **argv)
> +{
> +	int errors;
> +
> +	clar_test_init(argc, argv);
> +	errors = clar_test_run();
> +	clar_test_shutdown();
> +
> +	return errors;
> +}
> +
> +static void abort_test(void)
> +{
> +	if (!_clar.trampoline_enabled) {
> +		clar_print_onabort(
> +				"Fatal error: a cleanup method raised an exception.");
> +		clar_report_errors(_clar.last_report);
> +		exit(-1);
> +	}
> +
> +	CL_TRACE(CL_TRACE__TEST__LONGJMP);
> +	longjmp(_clar.trampoline, -1);
> +}
> +
> +void clar__skip(void)
> +{
> +	_clar.last_report->status = CL_TEST_SKIP;
> +	_clar.total_skipped++;
> +	abort_test();
> +}
> +
> +void clar__fail(
> +	const char *file,
> +	const char *function,
> +	size_t line,
> +	const char *error_msg,
> +	const char *description,
> +	int should_abort)
> +{
> +	struct clar_error *error = calloc(1, sizeof(struct clar_error));
> +
> +	if (_clar.last_report->errors == NULL)
> +		_clar.last_report->errors = error;
> +
> +	if (_clar.last_report->last_error != NULL)
> +		_clar.last_report->last_error->next = error;
> +
> +	_clar.last_report->last_error = error;
> +
> +	error->file = file;
> +	error->function = function;
> +	error->line_number = line;
> +	error->error_msg = error_msg;
> +
> +	if (description != NULL)
> +		error->description = strdup(description);
> +
> +	_clar.total_errors++;
> +	_clar.last_report->status = CL_TEST_FAILURE;
> +
> +	if (should_abort)
> +		abort_test();
> +}
> +
> +void clar__assert(
> +	int condition,
> +	const char *file,
> +	const char *function,
> +	size_t line,
> +	const char *error_msg,
> +	const char *description,
> +	int should_abort)
> +{
> +	if (condition)
> +		return;
> +
> +	clar__fail(file, function, line, error_msg, description, should_abort);
> +}
> +
> +void clar__assert_equal(
> +	const char *file,
> +	const char *function,
> +	size_t line,
> +	const char *err,
> +	int should_abort,
> +	const char *fmt,
> +	...)
> +{
> +	va_list args;
> +	char buf[4096];
> +	int is_equal = 1;
> +
> +	va_start(args, fmt);
> +
> +	if (!strcmp("%s", fmt)) {
> +		const char *s1 = va_arg(args, const char *);
> +		const char *s2 = va_arg(args, const char *);
> +		is_equal = (!s1 || !s2) ? (s1 == s2) : !strcmp(s1, s2);
> +
> +		if (!is_equal) {
> +			if (s1 && s2) {
> +				int pos;
> +				for (pos = 0; s1[pos] == s2[pos] && s1[pos] && s2[pos]; ++pos)
> +					/* find differing byte offset */;
> +				p_snprintf(buf, sizeof(buf), "'%s' != '%s' (at byte %d)",
> +					s1, s2, pos);
> +			} else {
> +				p_snprintf(buf, sizeof(buf), "'%s' != '%s'", s1, s2);
> +			}
> +		}
> +	}
> +	else if(!strcmp("%.*s", fmt)) {
> +		const char *s1 = va_arg(args, const char *);
> +		const char *s2 = va_arg(args, const char *);
> +		int len = va_arg(args, int);
> +		is_equal = (!s1 || !s2) ? (s1 == s2) : !strncmp(s1, s2, len);
> +
> +		if (!is_equal) {
> +			if (s1 && s2) {
> +				int pos;
> +				for (pos = 0; s1[pos] == s2[pos] && pos < len; ++pos)
> +					/* find differing byte offset */;
> +				p_snprintf(buf, sizeof(buf), "'%.*s' != '%.*s' (at byte %d)",
> +					len, s1, len, s2, pos);
> +			} else {
> +				p_snprintf(buf, sizeof(buf), "'%.*s' != '%.*s'", len, s1, len, s2);
> +			}
> +		}
> +	}
> +	else if (!strcmp("%ls", fmt)) {
> +		const wchar_t *wcs1 = va_arg(args, const wchar_t *);
> +		const wchar_t *wcs2 = va_arg(args, const wchar_t *);
> +		is_equal = (!wcs1 || !wcs2) ? (wcs1 == wcs2) : !wcscmp(wcs1, wcs2);
> +
> +		if (!is_equal) {
> +			if (wcs1 && wcs2) {
> +				int pos;
> +				for (pos = 0; wcs1[pos] == wcs2[pos] && wcs1[pos] && wcs2[pos]; ++pos)
> +					/* find differing byte offset */;
> +				p_snprintf(buf, sizeof(buf), "'%ls' != '%ls' (at byte %d)",
> +					wcs1, wcs2, pos);
> +			} else {
> +				p_snprintf(buf, sizeof(buf), "'%ls' != '%ls'", wcs1, wcs2);
> +			}
> +		}
> +	}
> +	else if(!strcmp("%.*ls", fmt)) {
> +		const wchar_t *wcs1 = va_arg(args, const wchar_t *);
> +		const wchar_t *wcs2 = va_arg(args, const wchar_t *);
> +		int len = va_arg(args, int);
> +		is_equal = (!wcs1 || !wcs2) ? (wcs1 == wcs2) : !wcsncmp(wcs1, wcs2, len);
> +
> +		if (!is_equal) {
> +			if (wcs1 && wcs2) {
> +				int pos;
> +				for (pos = 0; wcs1[pos] == wcs2[pos] && pos < len; ++pos)
> +					/* find differing byte offset */;
> +				p_snprintf(buf, sizeof(buf), "'%.*ls' != '%.*ls' (at byte %d)",
> +					len, wcs1, len, wcs2, pos);
> +			} else {
> +				p_snprintf(buf, sizeof(buf), "'%.*ls' != '%.*ls'", len, wcs1, len, wcs2);
> +			}
> +		}
> +	}
> +	else if (!strcmp("%"PRIuZ, fmt) || !strcmp("%"PRIxZ, fmt)) {
> +		size_t sz1 = va_arg(args, size_t), sz2 = va_arg(args, size_t);
> +		is_equal = (sz1 == sz2);
> +		if (!is_equal) {
> +			int offset = p_snprintf(buf, sizeof(buf), fmt, sz1);
> +			strncat(buf, " != ", sizeof(buf) - offset);
> +			p_snprintf(buf + offset + 4, sizeof(buf) - offset - 4, fmt, sz2);
> +		}
> +	}
> +	else if (!strcmp("%p", fmt)) {
> +		void *p1 = va_arg(args, void *), *p2 = va_arg(args, void *);
> +		is_equal = (p1 == p2);
> +		if (!is_equal)
> +			p_snprintf(buf, sizeof(buf), "%p != %p", p1, p2);
> +	}
> +	else {
> +		int i1 = va_arg(args, int), i2 = va_arg(args, int);
> +		is_equal = (i1 == i2);
> +		if (!is_equal) {
> +			int offset = p_snprintf(buf, sizeof(buf), fmt, i1);
> +			strncat(buf, " != ", sizeof(buf) - offset);
> +			p_snprintf(buf + offset + 4, sizeof(buf) - offset - 4, fmt, i2);
> +		}
> +	}
> +
> +	va_end(args);
> +
> +	if (!is_equal)
> +		clar__fail(file, function, line, err, buf, should_abort);
> +}
> +
> +void cl_set_cleanup(void (*cleanup)(void *), void *opaque)
> +{
> +	_clar.local_cleanup = cleanup;
> +	_clar.local_cleanup_payload = opaque;
> +}
> +
> +#include "clar/sandbox.h"
> +#include "clar/fixtures.h"
> +#include "clar/fs.h"
> +#include "clar/print.h"
> +#include "clar/summary.h"
> diff --git a/t/unit-tests/clar/clar.h b/t/unit-tests/clar/clar.h
> new file mode 100644
> index 0000000000..8c22382bd5
> --- /dev/null
> +++ b/t/unit-tests/clar/clar.h
> @@ -0,0 +1,173 @@
> +/*
> + * Copyright (c) Vicent Marti. All rights reserved.
> + *
> + * This file is part of clar, distributed under the ISC license.
> + * For full terms see the included COPYING file.
> + */
> +#ifndef __CLAR_TEST_H__
> +#define __CLAR_TEST_H__
> +
> +#include <stdlib.h>
> +
> +enum cl_test_status {
> +	CL_TEST_OK,
> +	CL_TEST_FAILURE,
> +	CL_TEST_SKIP,
> +	CL_TEST_NOTRUN,
> +};
> +
> +enum cl_output_format {
> +	CL_OUTPUT_CLAP,
> +	CL_OUTPUT_TAP,
> +};
> +
> +/** Setup clar environment */
> +void clar_test_init(int argc, char *argv[]);
> +int clar_test_run(void);
> +void clar_test_shutdown(void);
> +
> +/** One shot setup & run */
> +int clar_test(int argc, char *argv[]);
> +
> +const char *clar_sandbox_path(void);
> +
> +void cl_set_cleanup(void (*cleanup)(void *), void *opaque);
> +void cl_fs_cleanup(void);
> +
> +/**
> + * cl_trace_* is a hook to provide a simple global tracing
> + * mechanism.
> + *
> + * The goal here is to let main() provide clar-proper
> + * with a callback to optionally write log info for
> + * test operations into the same stream used by their
> + * actual tests.  This would let them print test names
> + * and maybe performance data as they choose.
> + *
> + * The goal is NOT to alter the flow of control or to
> + * override test selection/skipping.  (So the callback
> + * does not return a value.)
> + *
> + * The goal is NOT to duplicate the existing
> + * pass/fail/skip reporting.  (So the callback
> + * does not accept a status/errorcode argument.)
> + *
> + */
> +typedef enum cl_trace_event {
> +	CL_TRACE__SUITE_BEGIN,
> +	CL_TRACE__SUITE_END,
> +	CL_TRACE__TEST__BEGIN,
> +	CL_TRACE__TEST__END,
> +	CL_TRACE__TEST__RUN_BEGIN,
> +	CL_TRACE__TEST__RUN_END,
> +	CL_TRACE__TEST__LONGJMP,
> +} cl_trace_event;
> +
> +typedef void (cl_trace_cb)(
> +	cl_trace_event ev,
> +	const char *suite_name,
> +	const char *test_name,
> +	void *payload);
> +
> +/**
> + * Register a callback into CLAR to send global trace events.
> + * Pass NULL to disable.
> + */
> +void cl_trace_register(cl_trace_cb *cb, void *payload);
> +
> +
> +#ifdef CLAR_FIXTURE_PATH
> +const char *cl_fixture(const char *fixture_name);
> +void cl_fixture_sandbox(const char *fixture_name);
> +void cl_fixture_cleanup(const char *fixture_name);
> +const char *cl_fixture_basename(const char *fixture_name);
> +#endif
> +
> +/**
> + * Assertion macros with explicit error message
> + */
> +#define cl_must_pass_(expr, desc) clar__assert((expr) >= 0, __FILE__, __func__, __LINE__, "Function call failed: " #expr, desc, 1)
> +#define cl_must_fail_(expr, desc) clar__assert((expr) < 0, __FILE__, __func__, __LINE__, "Expected function call to fail: " #expr, desc, 1)
> +#define cl_assert_(expr, desc) clar__assert((expr) != 0, __FILE__, __func__, __LINE__, "Expression is not true: " #expr, desc, 1)
> +
> +/**
> + * Check macros with explicit error message
> + */
> +#define cl_check_pass_(expr, desc) clar__assert((expr) >= 0, __FILE__, __func__, __LINE__, "Function call failed: " #expr, desc, 0)
> +#define cl_check_fail_(expr, desc) clar__assert((expr) < 0, __FILE__, __func__, __LINE__, "Expected function call to fail: " #expr, desc, 0)
> +#define cl_check_(expr, desc) clar__assert((expr) != 0, __FILE__, __func__, __LINE__, "Expression is not true: " #expr, desc, 0)
> +
> +/**
> + * Assertion macros with no error message
> + */
> +#define cl_must_pass(expr) cl_must_pass_(expr, NULL)
> +#define cl_must_fail(expr) cl_must_fail_(expr, NULL)
> +#define cl_assert(expr) cl_assert_(expr, NULL)
> +
> +/**
> + * Check macros with no error message
> + */
> +#define cl_check_pass(expr) cl_check_pass_(expr, NULL)
> +#define cl_check_fail(expr) cl_check_fail_(expr, NULL)
> +#define cl_check(expr) cl_check_(expr, NULL)
> +
> +/**
> + * Forced failure/warning
> + */
> +#define cl_fail(desc) clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1)
> +#define cl_warning(desc) clar__fail(__FILE__, __func__, __LINE__, "Warning during test execution:", desc, 0)
> +
> +#define cl_skip() clar__skip()
> +
> +/**
> + * Typed assertion macros
> + */
> +#define cl_assert_equal_s(s1,s2) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #s1 " != " #s2, 1, "%s", (s1), (s2))
> +#define cl_assert_equal_s_(s1,s2,note) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #s1 " != " #s2 " (" #note ")", 1, "%s", (s1), (s2))
> +
> +#define cl_assert_equal_wcs(wcs1,wcs2) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #wcs1 " != " #wcs2, 1, "%ls", (wcs1), (wcs2))
> +#define cl_assert_equal_wcs_(wcs1,wcs2,note) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #wcs1 " != " #wcs2 " (" #note ")", 1, "%ls", (wcs1), (wcs2))
> +
> +#define cl_assert_equal_strn(s1,s2,len) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #s1 " != " #s2, 1, "%.*s", (s1), (s2), (int)(len))
> +#define cl_assert_equal_strn_(s1,s2,len,note) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #s1 " != " #s2 " (" #note ")", 1, "%.*s", (s1), (s2), (int)(len))
> +
> +#define cl_assert_equal_wcsn(wcs1,wcs2,len) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #wcs1 " != " #wcs2, 1, "%.*ls", (wcs1), (wcs2), (int)(len))
> +#define cl_assert_equal_wcsn_(wcs1,wcs2,len,note) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #wcs1 " != " #wcs2 " (" #note ")", 1, "%.*ls", (wcs1), (wcs2), (int)(len))
> +
> +#define cl_assert_equal_i(i1,i2) clar__assert_equal(__FILE__,__func__,__LINE__,#i1 " != " #i2, 1, "%d", (int)(i1), (int)(i2))
> +#define cl_assert_equal_i_(i1,i2,note) clar__assert_equal(__FILE__,__func__,__LINE__,#i1 " != " #i2 " (" #note ")", 1, "%d", (i1), (i2))
> +#define cl_assert_equal_i_fmt(i1,i2,fmt) clar__assert_equal(__FILE__,__func__,__LINE__,#i1 " != " #i2, 1, (fmt), (int)(i1), (int)(i2))
> +
> +#define cl_assert_equal_b(b1,b2) clar__assert_equal(__FILE__,__func__,__LINE__,#b1 " != " #b2, 1, "%d", (int)((b1) != 0),(int)((b2) != 0))
> +
> +#define cl_assert_equal_p(p1,p2) clar__assert_equal(__FILE__,__func__,__LINE__,"Pointer mismatch: " #p1 " != " #p2, 1, "%p", (p1), (p2))
> +
> +void clar__skip(void);
> +
> +void clar__fail(
> +	const char *file,
> +	const char *func,
> +	size_t line,
> +	const char *error,
> +	const char *description,
> +	int should_abort);
> +
> +void clar__assert(
> +	int condition,
> +	const char *file,
> +	const char *func,
> +	size_t line,
> +	const char *error,
> +	const char *description,
> +	int should_abort);
> +
> +void clar__assert_equal(
> +	const char *file,
> +	const char *func,
> +	size_t line,
> +	const char *err,
> +	int should_abort,
> +	const char *fmt,
> +	...);
> +
> +#endif
> diff --git a/t/unit-tests/clar/clar/fixtures.h b/t/unit-tests/clar/clar/fixtures.h
> new file mode 100644
> index 0000000000..6ec6423484
> --- /dev/null
> +++ b/t/unit-tests/clar/clar/fixtures.h
> @@ -0,0 +1,50 @@
> +#ifdef CLAR_FIXTURE_PATH
> +static const char *
> +fixture_path(const char *base, const char *fixture_name)
> +{
> +	static char _path[4096];
> +	size_t root_len;
> +
> +	root_len = strlen(base);
> +	strncpy(_path, base, sizeof(_path));
> +
> +	if (_path[root_len - 1] != '/')
> +		_path[root_len++] = '/';
> +
> +	if (fixture_name[0] == '/')
> +		fixture_name++;
> +
> +	strncpy(_path + root_len,
> +		fixture_name,
> +		sizeof(_path) - root_len);
> +
> +	return _path;
> +}
> +
> +const char *cl_fixture(const char *fixture_name)
> +{
> +	return fixture_path(CLAR_FIXTURE_PATH, fixture_name);
> +}
> +
> +void cl_fixture_sandbox(const char *fixture_name)
> +{
> +	fs_copy(cl_fixture(fixture_name), _clar_path);
> +}
> +
> +const char *cl_fixture_basename(const char *fixture_name)
> +{
> +	const char *p;
> +
> +	for (p = fixture_name; *p; p++) {
> +		if (p[0] == '/' && p[1] && p[1] != '/')
> +			fixture_name = p+1;
> +	}
> +
> +	return fixture_name;
> +}
> +
> +void cl_fixture_cleanup(const char *fixture_name)
> +{
> +	fs_rm(fixture_path(_clar_path, cl_fixture_basename(fixture_name)));
> +}
> +#endif
> diff --git a/t/unit-tests/clar/clar/fs.h b/t/unit-tests/clar/clar/fs.h
> new file mode 100644
> index 0000000000..3e39890bd3
> --- /dev/null
> +++ b/t/unit-tests/clar/clar/fs.h
> @@ -0,0 +1,522 @@
> +/*
> + * By default, use a read/write loop to copy files on POSIX systems.
> + * On Linux, use sendfile by default as it's slightly faster.  On
> + * macOS, we avoid fcopyfile by default because it's slightly slower.
> + */
> +#undef USE_FCOPYFILE
> +#define USE_SENDFILE 1
> +
> +#ifdef _WIN32
> +
> +#ifdef CLAR_WIN32_LONGPATHS
> +# define CLAR_MAX_PATH 4096
> +#else
> +# define CLAR_MAX_PATH MAX_PATH
> +#endif
> +
> +#define RM_RETRY_COUNT	5
> +#define RM_RETRY_DELAY	10
> +
> +#ifdef __MINGW32__
> +
> +/* These security-enhanced functions are not available
> + * in MinGW, so just use the vanilla ones */
> +#define wcscpy_s(a, b, c) wcscpy((a), (c))
> +#define wcscat_s(a, b, c) wcscat((a), (c))
> +
> +#endif /* __MINGW32__ */
> +
> +static int
> +fs__dotordotdot(WCHAR *_tocheck)
> +{
> +	return _tocheck[0] == '.' &&
> +		(_tocheck[1] == '\0' ||
> +		 (_tocheck[1] == '.' && _tocheck[2] == '\0'));
> +}
> +
> +static int
> +fs_rmdir_rmdir(WCHAR *_wpath)
> +{
> +	unsigned retries = 1;
> +
> +	while (!RemoveDirectoryW(_wpath)) {
> +		/* Only retry when we have retries remaining, and the
> +		 * error was ERROR_DIR_NOT_EMPTY. */
> +		if (retries++ > RM_RETRY_COUNT ||
> +			ERROR_DIR_NOT_EMPTY != GetLastError())
> +			return -1;
> +
> +		/* Give whatever has a handle to a child item some time
> +		 * to release it before trying again */
> +		Sleep(RM_RETRY_DELAY * retries * retries);
> +	}
> +
> +	return 0;
> +}
> +
> +static void translate_path(WCHAR *path, size_t path_size)
> +{
> +    size_t path_len, i;
> +
> +    if (wcsncmp(path, L"\\\\?\\", 4) == 0)
> +	return;
> +
> +    path_len = wcslen(path);
> +    cl_assert(path_size > path_len + 4);
> +
> +    for (i = path_len; i > 0; i--) {
> +	WCHAR c = path[i - 1];
> +
> +	if (c == L'/')
> +	    path[i + 3] = L'\\';
> +	else
> +	    path[i + 3] = path[i - 1];
> +    }
> +
> +    path[0] = L'\\';
> +    path[1] = L'\\';
> +    path[2] = L'?';
> +    path[3] = L'\\';
> +    path[path_len + 4] = L'\0';
> +}
> +
> +static void
> +fs_rmdir_helper(WCHAR *_wsource)
> +{
> +	WCHAR buffer[CLAR_MAX_PATH];
> +	HANDLE find_handle;
> +	WIN32_FIND_DATAW find_data;
> +	size_t buffer_prefix_len;
> +
> +	/* Set up the buffer and capture the length */
> +	wcscpy_s(buffer, CLAR_MAX_PATH, _wsource);
> +	translate_path(buffer, CLAR_MAX_PATH);
> +	wcscat_s(buffer, CLAR_MAX_PATH, L"\\");
> +	buffer_prefix_len = wcslen(buffer);
> +
> +	/* FindFirstFile needs a wildcard to match multiple items */
> +	wcscat_s(buffer, CLAR_MAX_PATH, L"*");
> +	find_handle = FindFirstFileW(buffer, &find_data);
> +	cl_assert(INVALID_HANDLE_VALUE != find_handle);
> +
> +	do {
> +		/* FindFirstFile/FindNextFile gives back . and ..
> +		 * entries at the beginning */
> +		if (fs__dotordotdot(find_data.cFileName))
> +			continue;
> +
> +		wcscpy_s(buffer + buffer_prefix_len, CLAR_MAX_PATH - buffer_prefix_len, find_data.cFileName);
> +
> +		if (FILE_ATTRIBUTE_DIRECTORY & find_data.dwFileAttributes)
> +			fs_rmdir_helper(buffer);
> +		else {
> +			/* If set, the +R bit must be cleared before deleting */
> +			if (FILE_ATTRIBUTE_READONLY & find_data.dwFileAttributes)
> +				cl_assert(SetFileAttributesW(buffer, find_data.dwFileAttributes & ~FILE_ATTRIBUTE_READONLY));
> +
> +			cl_assert(DeleteFileW(buffer));
> +		}
> +	}
> +	while (FindNextFileW(find_handle, &find_data));
> +
> +	/* Ensure that we successfully completed the enumeration */
> +	cl_assert(ERROR_NO_MORE_FILES == GetLastError());
> +
> +	/* Close the find handle */
> +	FindClose(find_handle);
> +
> +	/* Now that the directory is empty, remove it */
> +	cl_assert(0 == fs_rmdir_rmdir(_wsource));
> +}
> +
> +static int
> +fs_rm_wait(WCHAR *_wpath)
> +{
> +	unsigned retries = 1;
> +	DWORD last_error;
> +
> +	do {
> +		if (INVALID_FILE_ATTRIBUTES == GetFileAttributesW(_wpath))
> +			last_error = GetLastError();
> +		else
> +			last_error = ERROR_SUCCESS;
> +
> +		/* Is the item gone? */
> +		if (ERROR_FILE_NOT_FOUND == last_error ||
> +			ERROR_PATH_NOT_FOUND == last_error)
> +			return 0;
> +
> +		Sleep(RM_RETRY_DELAY * retries * retries);
> +	}
> +	while (retries++ <= RM_RETRY_COUNT);
> +
> +	return -1;
> +}
> +
> +static void
> +fs_rm(const char *_source)
> +{
> +	WCHAR wsource[CLAR_MAX_PATH];
> +	DWORD attrs;
> +
> +	/* The input path is UTF-8. Convert it to wide characters
> +	 * for use with the Windows API */
> +	cl_assert(MultiByteToWideChar(CP_UTF8,
> +				MB_ERR_INVALID_CHARS,
> +				_source,
> +				-1, /* Indicates NULL termination */
> +				wsource,
> +				CLAR_MAX_PATH));
> +
> +	translate_path(wsource, CLAR_MAX_PATH);
> +
> +	/* Does the item exist? If not, we have no work to do */
> +	attrs = GetFileAttributesW(wsource);
> +
> +	if (INVALID_FILE_ATTRIBUTES == attrs)
> +		return;
> +
> +	if (FILE_ATTRIBUTE_DIRECTORY & attrs)
> +		fs_rmdir_helper(wsource);
> +	else {
> +		/* The item is a file. Strip the +R bit */
> +		if (FILE_ATTRIBUTE_READONLY & attrs)
> +			cl_assert(SetFileAttributesW(wsource, attrs & ~FILE_ATTRIBUTE_READONLY));
> +
> +		cl_assert(DeleteFileW(wsource));
> +	}
> +
> +	/* Wait for the DeleteFile or RemoveDirectory call to complete */
> +	cl_assert(0 == fs_rm_wait(wsource));
> +}
> +
> +static void
> +fs_copydir_helper(WCHAR *_wsource, WCHAR *_wdest)
> +{
> +	WCHAR buf_source[CLAR_MAX_PATH], buf_dest[CLAR_MAX_PATH];
> +	HANDLE find_handle;
> +	WIN32_FIND_DATAW find_data;
> +	size_t buf_source_prefix_len, buf_dest_prefix_len;
> +
> +	wcscpy_s(buf_source, CLAR_MAX_PATH, _wsource);
> +	wcscat_s(buf_source, CLAR_MAX_PATH, L"\\");
> +	translate_path(buf_source, CLAR_MAX_PATH);
> +	buf_source_prefix_len = wcslen(buf_source);
> +
> +	wcscpy_s(buf_dest, CLAR_MAX_PATH, _wdest);
> +	wcscat_s(buf_dest, CLAR_MAX_PATH, L"\\");
> +	translate_path(buf_dest, CLAR_MAX_PATH);
> +	buf_dest_prefix_len = wcslen(buf_dest);
> +
> +	/* Get an enumerator for the items in the source. */
> +	wcscat_s(buf_source, CLAR_MAX_PATH, L"*");
> +	find_handle = FindFirstFileW(buf_source, &find_data);
> +	cl_assert(INVALID_HANDLE_VALUE != find_handle);
> +
> +	/* Create the target directory. */
> +	cl_assert(CreateDirectoryW(_wdest, NULL));
> +
> +	do {
> +		/* FindFirstFile/FindNextFile gives back . and ..
> +		 * entries at the beginning */
> +		if (fs__dotordotdot(find_data.cFileName))
> +			continue;
> +
> +		wcscpy_s(buf_source + buf_source_prefix_len, CLAR_MAX_PATH - buf_source_prefix_len, find_data.cFileName);
> +		wcscpy_s(buf_dest + buf_dest_prefix_len, CLAR_MAX_PATH - buf_dest_prefix_len, find_data.cFileName);
> +
> +		if (FILE_ATTRIBUTE_DIRECTORY & find_data.dwFileAttributes)
> +			fs_copydir_helper(buf_source, buf_dest);
> +		else
> +			cl_assert(CopyFileW(buf_source, buf_dest, TRUE));
> +	}
> +	while (FindNextFileW(find_handle, &find_data));
> +
> +	/* Ensure that we successfully completed the enumeration */
> +	cl_assert(ERROR_NO_MORE_FILES == GetLastError());
> +
> +	/* Close the find handle */
> +	FindClose(find_handle);
> +}
> +
> +static void
> +fs_copy(const char *_source, const char *_dest)
> +{
> +	WCHAR wsource[CLAR_MAX_PATH], wdest[CLAR_MAX_PATH];
> +	DWORD source_attrs, dest_attrs;
> +	HANDLE find_handle;
> +	WIN32_FIND_DATAW find_data;
> +
> +	/* The input paths are UTF-8. Convert them to wide characters
> +	 * for use with the Windows API. */
> +	cl_assert(MultiByteToWideChar(CP_UTF8,
> +				MB_ERR_INVALID_CHARS,
> +				_source,
> +				-1,
> +				wsource,
> +				CLAR_MAX_PATH));
> +
> +	cl_assert(MultiByteToWideChar(CP_UTF8,
> +				MB_ERR_INVALID_CHARS,
> +				_dest,
> +				-1,
> +				wdest,
> +				CLAR_MAX_PATH));
> +
> +	translate_path(wsource, CLAR_MAX_PATH);
> +	translate_path(wdest, CLAR_MAX_PATH);
> +
> +	/* Check the source for existence */
> +	source_attrs = GetFileAttributesW(wsource);
> +	cl_assert(INVALID_FILE_ATTRIBUTES != source_attrs);
> +
> +	/* Check the target for existence */
> +	dest_attrs = GetFileAttributesW(wdest);
> +
> +	if (INVALID_FILE_ATTRIBUTES != dest_attrs) {
> +		/* Target exists; append last path part of source to target.
> +		 * Use FindFirstFile to parse the path */
> +		find_handle = FindFirstFileW(wsource, &find_data);
> +		cl_assert(INVALID_HANDLE_VALUE != find_handle);
> +		wcscat_s(wdest, CLAR_MAX_PATH, L"\\");
> +		wcscat_s(wdest, CLAR_MAX_PATH, find_data.cFileName);
> +		FindClose(find_handle);
> +
> +		/* Check the new target for existence */
> +		cl_assert(INVALID_FILE_ATTRIBUTES == GetFileAttributesW(wdest));
> +	}
> +
> +	if (FILE_ATTRIBUTE_DIRECTORY & source_attrs)
> +		fs_copydir_helper(wsource, wdest);
> +	else
> +		cl_assert(CopyFileW(wsource, wdest, TRUE));
> +}
> +
> +void
> +cl_fs_cleanup(void)
> +{
> +#ifdef CLAR_FIXTURE_PATH
> +	fs_rm(fixture_path(_clar_path, "*"));
> +#endif
> +}
> +
> +#else
> +
> +#include <errno.h>
> +#include <string.h>
> +#include <limits.h>
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +#if defined(__linux__)
> +# include <sys/sendfile.h>
> +#endif
> +
> +#if defined(__APPLE__)
> +# include <copyfile.h>
> +#endif
> +
> +static void basename_r(const char **out, int *out_len, const char *in)
> +{
> +	size_t in_len = strlen(in), start_pos;
> +
> +	for (in_len = strlen(in); in_len; in_len--) {
> +		if (in[in_len - 1] != '/')
> +			break;
> +	}
> +
> +	for (start_pos = in_len; start_pos; start_pos--) {
> +		if (in[start_pos - 1] == '/')
> +			break;
> +	}
> +
> +	cl_assert(in_len - start_pos < INT_MAX);
> +
> +	if (in_len - start_pos > 0) {
> +		*out = &in[start_pos];
> +		*out_len = (in_len - start_pos);
> +	} else {
> +		*out = "/";
> +		*out_len = 1;
> +	}
> +}
> +
> +static char *joinpath(const char *dir, const char *base, int base_len)
> +{
> +	char *out;
> +	int len;
> +
> +	if (base_len == -1) {
> +		size_t bl = strlen(base);
> +
> +		cl_assert(bl < INT_MAX);
> +		base_len = (int)bl;
> +	}
> +
> +	len = strlen(dir) + base_len + 2;
> +	cl_assert(len > 0);
> +
> +	cl_assert(out = malloc(len));
> +	cl_assert(snprintf(out, len, "%s/%.*s", dir, base_len, base) < len);
> +
> +	return out;
> +}
> +
> +static void
> +fs_copydir_helper(const char *source, const char *dest, int dest_mode)
> +{
> +	DIR *source_dir;
> +	struct dirent *d;
> +
> +	mkdir(dest, dest_mode);
> +
> +	cl_assert_(source_dir = opendir(source), "Could not open source dir");
> +	while ((d = (errno = 0, readdir(source_dir))) != NULL) {
> +		char *child;
> +
> +		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +			continue;
> +
> +		child = joinpath(source, d->d_name, -1);
> +		fs_copy(child, dest);
> +		free(child);
> +	}
> +
> +	cl_assert_(errno == 0, "Failed to iterate source dir");
> +
> +	closedir(source_dir);
> +}
> +
> +static void
> +fs_copyfile_helper(const char *source, size_t source_len, const char *dest, int dest_mode)
> +{
> +	int in, out;
> +
> +	cl_must_pass((in = open(source, O_RDONLY)));
> +	cl_must_pass((out = open(dest, O_WRONLY|O_CREAT|O_TRUNC, dest_mode)));
> +
> +#if USE_FCOPYFILE && defined(__APPLE__)
> +	((void)(source_len)); /* unused */
> +	cl_must_pass(fcopyfile(in, out, 0, COPYFILE_DATA));
> +#elif USE_SENDFILE && defined(__linux__)
> +	{
> +		ssize_t ret = 0;
> +
> +		while (source_len && (ret = sendfile(out, in, NULL, source_len)) > 0) {
> +			source_len -= (size_t)ret;
> +		}
> +		cl_assert(ret >= 0);
> +	}
> +#else
> +	{
> +		char buf[131072];
> +		ssize_t ret;
> +
> +		((void)(source_len)); /* unused */
> +
> +		while ((ret = read(in, buf, sizeof(buf))) > 0) {
> +			size_t len = (size_t)ret;
> +
> +			while (len && (ret = write(out, buf, len)) > 0) {
> +				cl_assert(ret <= (ssize_t)len);
> +				len -= ret;
> +			}
> +			cl_assert(ret >= 0);
> +		}
> +		cl_assert(ret == 0);
> +	}
> +#endif
> +
> +	close(in);
> +	close(out);
> +}
> +
> +static void
> +fs_copy(const char *source, const char *_dest)
> +{
> +	char *dbuf = NULL;
> +	const char *dest = NULL;
> +	struct stat source_st, dest_st;
> +
> +	cl_must_pass_(lstat(source, &source_st), "Failed to stat copy source");
> +
> +	if (lstat(_dest, &dest_st) == 0) {
> +		const char *base;
> +		int base_len;
> +
> +		/* Target exists and is directory; append basename */
> +		cl_assert(S_ISDIR(dest_st.st_mode));
> +
> +		basename_r(&base, &base_len, source);
> +		cl_assert(base_len < INT_MAX);
> +
> +		dbuf = joinpath(_dest, base, base_len);
> +		dest = dbuf;
> +	} else if (errno != ENOENT) {
> +		cl_fail("Cannot copy; cannot stat destination");
> +	} else {
> +		dest = _dest;
> +	}
> +
> +	if (S_ISDIR(source_st.st_mode)) {
> +		fs_copydir_helper(source, dest, source_st.st_mode);
> +	} else {
> +		fs_copyfile_helper(source, source_st.st_size, dest, source_st.st_mode);
> +	}
> +
> +	free(dbuf);
> +}
> +
> +static void
> +fs_rmdir_helper(const char *path)
> +{
> +	DIR *dir;
> +	struct dirent *d;
> +
> +	cl_assert_(dir = opendir(path), "Could not open dir");
> +	while ((d = (errno = 0, readdir(dir))) != NULL) {
> +		char *child;
> +
> +		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +			continue;
> +
> +		child = joinpath(path, d->d_name, -1);
> +		fs_rm(child);
> +		free(child);
> +	}
> +
> +	cl_assert_(errno == 0, "Failed to iterate source dir");
> +	closedir(dir);
> +
> +	cl_must_pass_(rmdir(path), "Could not remove directory");
> +}
> +
> +static void
> +fs_rm(const char *path)
> +{
> +	struct stat st;
> +
> +	if (lstat(path, &st)) {
> +		if (errno == ENOENT)
> +			return;
> +
> +		cl_fail("Cannot copy; cannot stat destination");
> +	}
> +
> +	if (S_ISDIR(st.st_mode)) {
> +		fs_rmdir_helper(path);
> +	} else {
> +		cl_must_pass(unlink(path));
> +	}
> +}
> +
> +void
> +cl_fs_cleanup(void)
> +{
> +	clar_unsandbox();
> +	clar_sandbox();
> +}
> +#endif
> diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
> new file mode 100644
> index 0000000000..c17e2f693b
> --- /dev/null
> +++ b/t/unit-tests/clar/clar/print.h
> @@ -0,0 +1,211 @@
> +/* clap: clar protocol, the traditional clar output format */
> +
> +static void clar_print_clap_init(int test_count, int suite_count, const char *suite_names)
> +{
> +	(void)test_count;
> +	printf("Loaded %d suites: %s\n", (int)suite_count, suite_names);
> +	printf("Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')\n");
> +}
> +
> +static void clar_print_clap_shutdown(int test_count, int suite_count, int error_count)
> +{
> +	(void)test_count;
> +	(void)suite_count;
> +	(void)error_count;
> +
> +	printf("\n\n");
> +	clar_report_all();
> +}
> +
> +static void clar_print_clap_error(int num, const struct clar_report *report, const struct clar_error *error)
> +{
> +	printf("  %d) Failure:\n", num);
> +
> +	printf("%s::%s [%s:%"PRIuZ"]\n",
> +		report->suite,
> +		report->test,
> +		error->file,
> +		error->line_number);
> +
> +	printf("  %s\n", error->error_msg);
> +
> +	if (error->description != NULL)
> +		printf("  %s\n", error->description);
> +
> +	printf("\n");
> +	fflush(stdout);
> +}
> +
> +static void clar_print_clap_ontest(const char *suite_name, const char *test_name, int test_number, enum cl_test_status status)
> +{
> +	(void)test_name;
> +	(void)test_number;
> +
> +	if (_clar.verbosity > 1) {
> +		printf("%s::%s: ", suite_name, test_name);
> +
> +		switch (status) {
> +		case CL_TEST_OK: printf("ok\n"); break;
> +		case CL_TEST_FAILURE: printf("fail\n"); break;
> +		case CL_TEST_SKIP: printf("skipped"); break;
> +		case CL_TEST_NOTRUN: printf("notrun"); break;
> +		}
> +	} else {
> +		switch (status) {
> +		case CL_TEST_OK: printf("."); break;
> +		case CL_TEST_FAILURE: printf("F"); break;
> +		case CL_TEST_SKIP: printf("S"); break;
> +		case CL_TEST_NOTRUN: printf("N"); break;
> +		}
> +
> +		fflush(stdout);
> +	}
> +}
> +
> +static void clar_print_clap_onsuite(const char *suite_name, int suite_index)
> +{
> +	if (_clar.verbosity == 1)
> +		printf("\n%s", suite_name);
> +
> +	(void)suite_index;
> +}
> +
> +static void clar_print_clap_onabort(const char *fmt, va_list arg)
> +{
> +	vfprintf(stderr, fmt, arg);
> +}
> +
> +/* tap: test anywhere protocol format */
> +
> +static void clar_print_tap_init(int test_count, int suite_count, const char *suite_names)
> +{
> +	(void)test_count;
> +	(void)suite_count;
> +	(void)suite_names;
> +	printf("TAP version 13\n");
> +}
> +
> +static void clar_print_tap_shutdown(int test_count, int suite_count, int error_count)
> +{
> +	(void)suite_count;
> +	(void)error_count;
> +
> +	printf("1..%d\n", test_count);
> +}
> +
> +static void clar_print_tap_error(int num, const struct clar_report *report, const struct clar_error *error)
> +{
> +	(void)num;
> +	(void)report;
> +	(void)error;
> +}
> +
> +static void print_escaped(const char *str)
> +{
> +	char *c;
> +
> +	while ((c = strchr(str, '\'')) != NULL) {
> +		printf("%.*s", (int)(c - str), str);
> +		printf("''");
> +		str = c + 1;
> +	}
> +
> +	printf("%s", str);
> +}
> +
> +static void clar_print_tap_ontest(const char *suite_name, const char *test_name, int test_number, enum cl_test_status status)
> +{
> +	const struct clar_error *error = _clar.last_report->errors;
> +
> +	(void)test_name;
> +	(void)test_number;
> +
> +	switch(status) {
> +	case CL_TEST_OK:
> +		printf("ok %d - %s::%s\n", test_number, suite_name, test_name);
> +		break;
> +	case CL_TEST_FAILURE:
> +		printf("not ok %d - %s::%s\n", test_number, suite_name, test_name);
> +
> +		printf("    ---\n");
> +		printf("    reason: |\n");
> +		printf("      %s\n", error->error_msg);
> +
> +		if (error->description)
> +			printf("      %s\n", error->description);
> +
> +		printf("    at:\n");
> +		printf("      file: '"); print_escaped(error->file); printf("'\n");
> +		printf("      line: %" PRIuZ "\n", error->line_number);
> +		printf("      function: '%s'\n", error->function);
> +		printf("    ---\n");
> +
> +		break;
> +	case CL_TEST_SKIP:
> +	case CL_TEST_NOTRUN:
> +		printf("ok %d - # SKIP %s::%s\n", test_number, suite_name, test_name);
> +		break;
> +	}
> +
> +	fflush(stdout);
> +}
> +
> +static void clar_print_tap_onsuite(const char *suite_name, int suite_index)
> +{
> +	printf("# start of suite %d: %s\n", suite_index, suite_name);
> +}
> +
> +static void clar_print_tap_onabort(const char *fmt, va_list arg)
> +{
> +	printf("Bail out! ");
> +	vprintf(fmt, arg);
> +	fflush(stdout);
> +}
> +
> +/* indirection between protocol output selection */
> +
> +#define PRINT(FN, ...) do { \
> +		switch (_clar.output_format) { \
> +			case CL_OUTPUT_CLAP: \
> +				clar_print_clap_##FN (__VA_ARGS__); \
> +				break; \
> +			case CL_OUTPUT_TAP: \
> +				clar_print_tap_##FN (__VA_ARGS__); \
> +				break; \
> +			default: \
> +				abort(); \
> +		} \
> +	} while (0)
> +
> +static void clar_print_init(int test_count, int suite_count, const char *suite_names)
> +{
> +	PRINT(init, test_count, suite_count, suite_names);
> +}
> +
> +static void clar_print_shutdown(int test_count, int suite_count, int error_count)
> +{
> +	PRINT(shutdown, test_count, suite_count, error_count);
> +}
> +
> +static void clar_print_error(int num, const struct clar_report *report, const struct clar_error *error)
> +{
> +	PRINT(error, num, report, error);
> +}
> +
> +static void clar_print_ontest(const char *suite_name, const char *test_name, int test_number, enum cl_test_status status)
> +{
> +	PRINT(ontest, suite_name, test_name, test_number, status);
> +}
> +
> +static void clar_print_onsuite(const char *suite_name, int suite_index)
> +{
> +	PRINT(onsuite, suite_name, suite_index);
> +}
> +
> +static void clar_print_onabort(const char *msg, ...)
> +{
> +	va_list argp;
> +	va_start(argp, msg);
> +	PRINT(onabort, msg, argp);
> +	va_end(argp);
> +}
> diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
> new file mode 100644
> index 0000000000..7c177f3525
> --- /dev/null
> +++ b/t/unit-tests/clar/clar/sandbox.h
> @@ -0,0 +1,153 @@
> +#ifdef __APPLE__
> +#include <sys/syslimits.h>
> +#endif
> +
> +static char _clar_path[4096 + 1];
> +
> +static int
> +is_valid_tmp_path(const char *path)
> +{
> +	STAT_T st;
> +
> +	if (stat(path, &st) != 0)
> +		return 0;
> +
> +	if (!S_ISDIR(st.st_mode))
> +		return 0;
> +
> +	return (access(path, W_OK) == 0);
> +}
> +
> +static int
> +find_tmp_path(char *buffer, size_t length)
> +{
> +#ifndef _WIN32
> +	static const size_t var_count = 5;
> +	static const char *env_vars[] = {
> +		"CLAR_TMP", "TMPDIR", "TMP", "TEMP", "USERPROFILE"
> +	};
> +
> +	size_t i;
> +
> +	for (i = 0; i < var_count; ++i) {
> +		const char *env = getenv(env_vars[i]);
> +		if (!env)
> +			continue;
> +
> +		if (is_valid_tmp_path(env)) {
> +#ifdef __APPLE__
> +			if (length >= PATH_MAX && realpath(env, buffer) != NULL)
> +				return 0;
> +#endif
> +			strncpy(buffer, env, length - 1);
> +			buffer[length - 1] = '\0';
> +			return 0;
> +		}
> +	}
> +
> +	/* If the environment doesn't say anything, try to use /tmp */
> +	if (is_valid_tmp_path("/tmp")) {
> +#ifdef __APPLE__
> +		if (length >= PATH_MAX && realpath("/tmp", buffer) != NULL)
> +			return 0;
> +#endif
> +		strncpy(buffer, "/tmp", length - 1);
> +		buffer[length - 1] = '\0';
> +		return 0;
> +	}
> +
> +#else
> +	DWORD env_len = GetEnvironmentVariable("CLAR_TMP", buffer, (DWORD)length);
> +	if (env_len > 0 && env_len < (DWORD)length)
> +		return 0;
> +
> +	if (GetTempPath((DWORD)length, buffer))
> +		return 0;
> +#endif
> +
> +	/* This system doesn't like us, try to use the current directory */
> +	if (is_valid_tmp_path(".")) {
> +		strncpy(buffer, ".", length - 1);
> +		buffer[length - 1] = '\0';
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
> +static void clar_unsandbox(void)
> +{
> +	if (_clar_path[0] == '\0')
> +		return;
> +
> +	cl_must_pass(chdir(".."));
> +
> +	fs_rm(_clar_path);
> +}
> +
> +static int build_sandbox_path(void)
> +{
> +#ifdef CLAR_TMPDIR
> +	const char path_tail[] = CLAR_TMPDIR "_XXXXXX";
> +#else
> +	const char path_tail[] = "clar_tmp_XXXXXX";
> +#endif
> +
> +	size_t len;
> +
> +	if (find_tmp_path(_clar_path, sizeof(_clar_path)) < 0)
> +		return -1;
> +
> +	len = strlen(_clar_path);
> +
> +#ifdef _WIN32
> +	{ /* normalize path to POSIX forward slashes */
> +		size_t i;
> +		for (i = 0; i < len; ++i) {
> +			if (_clar_path[i] == '\\')
> +				_clar_path[i] = '/';
> +		}
> +	}
> +#endif
> +
> +	if (_clar_path[len - 1] != '/') {
> +		_clar_path[len++] = '/';
> +	}
> +
> +	strncpy(_clar_path + len, path_tail, sizeof(_clar_path) - len);
> +
> +#if defined(__MINGW32__)
> +	if (_mktemp(_clar_path) == NULL)
> +		return -1;
> +
> +	if (mkdir(_clar_path, 0700) != 0)
> +		return -1;
> +#elif defined(_WIN32)
> +	if (_mktemp_s(_clar_path, sizeof(_clar_path)) != 0)
> +		return -1;
> +
> +	if (mkdir(_clar_path, 0700) != 0)
> +		return -1;
> +#else
> +	if (mkdtemp(_clar_path) == NULL)
> +		return -1;
> +#endif
> +
> +	return 0;
> +}
> +
> +static int clar_sandbox(void)
> +{
> +	if (_clar_path[0] == '\0' && build_sandbox_path() < 0)
> +		return -1;
> +
> +	if (chdir(_clar_path) != 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +const char *clar_sandbox_path(void)
> +{
> +	return _clar_path;
> +}
> diff --git a/t/unit-tests/clar/clar/summary.h b/t/unit-tests/clar/clar/summary.h
> new file mode 100644
> index 0000000000..4dd352e28b
> --- /dev/null
> +++ b/t/unit-tests/clar/clar/summary.h
> @@ -0,0 +1,143 @@
> +
> +#include <stdio.h>
> +#include <time.h>
> +
> +static int clar_summary_close_tag(
> +    struct clar_summary *summary, const char *tag, int indent)
> +{
> +	const char *indt;
> +
> +	if (indent == 0) indt = "";
> +	else if (indent == 1) indt = "\t";
> +	else indt = "\t\t";
> +
> +	return fprintf(summary->fp, "%s</%s>\n", indt, tag);
> +}
> +
> +static int clar_summary_testsuites(struct clar_summary *summary)
> +{
> +	return fprintf(summary->fp, "<testsuites>\n");
> +}
> +
> +static int clar_summary_testsuite(struct clar_summary *summary,
> +    int idn, const char *name, time_t timestamp,
> +    int test_count, int fail_count, int error_count)
> +{
> +	struct tm *tm = localtime(&timestamp);
> +	char iso_dt[20];
> +
> +	if (strftime(iso_dt, sizeof(iso_dt), "%Y-%m-%dT%H:%M:%S", tm) == 0)
> +		return -1;
> +
> +	return fprintf(summary->fp, "\t<testsuite"
> +		       " id=\"%d\""
> +		       " name=\"%s\""
> +		       " hostname=\"localhost\""
> +		       " timestamp=\"%s\""
> +		       " tests=\"%d\""
> +		       " failures=\"%d\""
> +		       " errors=\"%d\">\n",
> +		       idn, name, iso_dt, test_count, fail_count, error_count);
> +}
> +
> +static int clar_summary_testcase(struct clar_summary *summary,
> +    const char *name, const char *classname, double elapsed)
> +{
> +	return fprintf(summary->fp,
> +	    "\t\t<testcase name=\"%s\" classname=\"%s\" time=\"%.2f\">\n",
> +		name, classname, elapsed);
> +}
> +
> +static int clar_summary_failure(struct clar_summary *summary,
> +    const char *type, const char *message, const char *desc)
> +{
> +	return fprintf(summary->fp,
> +	    "\t\t\t<failure type=\"%s\"><![CDATA[%s\n%s]]></failure>\n",
> +	    type, message, desc);
> +}
> +
> +static int clar_summary_skipped(struct clar_summary *summary)
> +{
> +	return fprintf(summary->fp, "\t\t\t<skipped />\n");
> +}
> +
> +struct clar_summary *clar_summary_init(const char *filename)
> +{
> +	struct clar_summary *summary;
> +	FILE *fp;
> +
> +	if ((fp = fopen(filename, "w")) == NULL) {
> +		perror("fopen");
> +		return NULL;
> +	}
> +
> +	if ((summary = malloc(sizeof(struct clar_summary))) == NULL) {
> +		perror("malloc");
> +		fclose(fp);
> +		return NULL;
> +	}
> +
> +	summary->filename = filename;
> +	summary->fp = fp;
> +
> +	return summary;
> +}
> +
> +int clar_summary_shutdown(struct clar_summary *summary)
> +{
> +	struct clar_report *report;
> +	const char *last_suite = NULL;
> +
> +	if (clar_summary_testsuites(summary) < 0)
> +		goto on_error;
> +
> +	report = _clar.reports;
> +	while (report != NULL) {
> +		struct clar_error *error = report->errors;
> +
> +		if (last_suite == NULL || strcmp(last_suite, report->suite) != 0) {
> +			if (clar_summary_testsuite(summary, 0, report->suite,
> +			    report->start, _clar.tests_ran, _clar.total_errors, 0) < 0)
> +				goto on_error;
> +		}
> +
> +		last_suite = report->suite;
> +
> +		clar_summary_testcase(summary, report->test, report->suite, report->elapsed);
> +
> +		while (error != NULL) {
> +			if (clar_summary_failure(summary, "assert",
> +			    error->error_msg, error->description) < 0)
> +				goto on_error;
> +
> +			error = error->next;
> +		}
> +
> +		if (report->status == CL_TEST_SKIP)
> +			clar_summary_skipped(summary);
> +
> +		if (clar_summary_close_tag(summary, "testcase", 2) < 0)
> +			goto on_error;
> +
> +		report = report->next;
> +
> +		if (!report || strcmp(last_suite, report->suite) != 0) {
> +			if (clar_summary_close_tag(summary, "testsuite", 1) < 0)
> +				goto on_error;
> +		}
> +	}
> +
> +	if (clar_summary_close_tag(summary, "testsuites", 0) < 0 ||
> +	    fclose(summary->fp) != 0)
> +		goto on_error;
> +
> +	printf("written summary file to %s\n", summary->filename);
> +
> +	free(summary);
> +	return 0;
> +
> +on_error:
> +	fclose(summary->fp);
> +	free(summary);
> +	return -1;
> +}
> diff --git a/t/unit-tests/clar/generate.py b/t/unit-tests/clar/generate.py
> new file mode 100755
> index 0000000000..80996ac3e7
> --- /dev/null
> +++ b/t/unit-tests/clar/generate.py
> @@ -0,0 +1,266 @@
> +#!/usr/bin/env python
> +#
> +# Copyright (c) Vicent Marti. All rights reserved.
> +#
> +# This file is part of clar, distributed under the ISC license.
> +# For full terms see the included COPYING file.
> +#
> +
> +from __future__ import with_statement
> +from string import Template
> +import re, fnmatch, os, sys, codecs, pickle
> +
> +class Module(object):
> +    class Template(object):
> +        def __init__(self, module):
> +            self.module = module
> +
> +        def _render_callback(self, cb):
> +            if not cb:
> +                return '    { NULL, NULL }'
> +            return '    { "%s", &%s }' % (cb['short_name'], cb['symbol'])
> +
> +    class DeclarationTemplate(Template):
> +        def render(self):
> +            out = "\n".join("extern %s;" % cb['declaration'] for cb in self.module.callbacks) + "\n"
> +
> +            for initializer in self.module.initializers:
> +                out += "extern %s;\n" % initializer['declaration']
> +
> +            if self.module.cleanup:
> +                out += "extern %s;\n" % self.module.cleanup['declaration']
> +
> +            return out
> +
> +    class CallbacksTemplate(Template):
> +        def render(self):
> +            out = "static const struct clar_func _clar_cb_%s[] = {\n" % self.module.name
> +            out += ",\n".join(self._render_callback(cb) for cb in self.module.callbacks)
> +            out += "\n};\n"
> +            return out
> +
> +    class InfoTemplate(Template):
> +        def render(self):
> +            templates = []
> +
> +            initializers = self.module.initializers
> +            if len(initializers) == 0:
> +                initializers = [ None ]
> +
> +            for initializer in initializers:
> +                name = self.module.clean_name()
> +                if initializer and initializer['short_name'].startswith('initialize_'):
> +                    variant = initializer['short_name'][len('initialize_'):]
> +                    name += " (%s)" % variant.replace('_', ' ')
> +
> +                template = Template(
> +            r"""
> +    {
> +        "${clean_name}",
> +    ${initialize},
> +    ${cleanup},
> +        ${cb_ptr}, ${cb_count}, ${enabled}
> +    }"""
> +                ).substitute(
> +                    clean_name = name,
> +                    initialize = self._render_callback(initializer),
> +                    cleanup = self._render_callback(self.module.cleanup),
> +                    cb_ptr = "_clar_cb_%s" % self.module.name,
> +                    cb_count = len(self.module.callbacks),
> +                    enabled = int(self.module.enabled)
> +                )
> +                templates.append(template)
> +
> +            return ','.join(templates)
> +
> +    def __init__(self, name):
> +        self.name = name
> +
> +        self.mtime = None
> +        self.enabled = True
> +        self.modified = False
> +
> +    def clean_name(self):
> +        return self.name.replace("_", "::")
> +
> +    def _skip_comments(self, text):
> +        SKIP_COMMENTS_REGEX = re.compile(
> +            r'//.*?$|/\*.*?\*/|\'(?:\\.|[^\\\'])*\'|"(?:\\.|[^\\"])*"',
> +            re.DOTALL | re.MULTILINE)
> +
> +        def _replacer(match):
> +            s = match.group(0)
> +            return "" if s.startswith('/') else s
> +
> +        return re.sub(SKIP_COMMENTS_REGEX, _replacer, text)
> +
> +    def parse(self, contents):
> +        TEST_FUNC_REGEX = r"^(void\s+(test_%s__(\w+))\s*\(\s*void\s*\))\s*\{"
> +
> +        contents = self._skip_comments(contents)
> +        regex = re.compile(TEST_FUNC_REGEX % self.name, re.MULTILINE)
> +
> +        self.callbacks = []
> +        self.initializers = []
> +        self.cleanup = None
> +
> +        for (declaration, symbol, short_name) in regex.findall(contents):
> +            data = {
> +                "short_name" : short_name,
> +                "declaration" : declaration,
> +                "symbol" : symbol
> +            }
> +
> +            if short_name.startswith('initialize'):
> +                self.initializers.append(data)
> +            elif short_name == 'cleanup':
> +                self.cleanup = data
> +            else:
> +                self.callbacks.append(data)
> +
> +        return self.callbacks != []
> +
> +    def refresh(self, path):
> +        self.modified = False
> +
> +        try:
> +            st = os.stat(path)
> +
> +            # Not modified
> +            if st.st_mtime == self.mtime:
> +                return True
> +
> +            self.modified = True
> +            self.mtime = st.st_mtime
> +
> +            with codecs.open(path, encoding='utf-8') as fp:
> +                raw_content = fp.read()
> +
> +        except IOError:
> +            return False
> +
> +        return self.parse(raw_content)
> +
> +class TestSuite(object):
> +
> +    def __init__(self, path, output):
> +        self.path = path
> +        self.output = output
> +
> +    def should_generate(self, path):
> +        if not os.path.isfile(path):
> +            return True
> +
> +        if any(module.modified for module in self.modules.values()):
> +            return True
> +
> +        return False
> +
> +    def find_modules(self):
> +        modules = []
> +        for root, _, files in os.walk(self.path):
> +            module_root = root[len(self.path):]
> +            module_root = [c for c in module_root.split(os.sep) if c]
> +
> +            tests_in_module = fnmatch.filter(files, "*.c")
> +
> +            for test_file in tests_in_module:
> +                full_path = os.path.join(root, test_file)
> +                module_name = "_".join(module_root + [test_file[:-2]]).replace("-", "_")
> +
> +                modules.append((full_path, module_name))
> +
> +        return modules
> +
> +    def load_cache(self):
> +        path = os.path.join(self.output, '.clarcache')
> +        cache = {}
> +
> +        try:
> +            fp = open(path, 'rb')
> +            cache = pickle.load(fp)
> +            fp.close()
> +        except (IOError, ValueError):
> +            pass
> +
> +        return cache
> +
> +    def save_cache(self):
> +        path = os.path.join(self.output, '.clarcache')
> +        with open(path, 'wb') as cache:
> +            pickle.dump(self.modules, cache)
> +
> +    def load(self, force = False):
> +        module_data = self.find_modules()
> +        self.modules = {} if force else self.load_cache()
> +
> +        for path, name in module_data:
> +            if name not in self.modules:
> +                self.modules[name] = Module(name)
> +
> +            if not self.modules[name].refresh(path):
> +                del self.modules[name]
> +
> +    def disable(self, excluded):
> +        for exclude in excluded:
> +            for module in self.modules.values():
> +                name = module.clean_name()
> +                if name.startswith(exclude):
> +                    module.enabled = False
> +                    module.modified = True
> +
> +    def suite_count(self):
> +        return sum(max(1, len(m.initializers)) for m in self.modules.values())
> +
> +    def callback_count(self):
> +        return sum(len(module.callbacks) for module in self.modules.values())
> +
> +    def write(self):
> +        output = os.path.join(self.output, 'clar.suite')
> +
> +        if not self.should_generate(output):
> +            return False
> +
> +        with open(output, 'w') as data:
> +            modules = sorted(self.modules.values(), key=lambda module: module.name)
> +
> +            for module in modules:
> +                t = Module.DeclarationTemplate(module)
> +                data.write(t.render())
> +
> +            for module in modules:
> +                t = Module.CallbacksTemplate(module)
> +                data.write(t.render())
> +
> +            suites = "static struct clar_suite _clar_suites[] = {" + ','.join(
> +                Module.InfoTemplate(module).render() for module in modules
> +            ) + "\n};\n"
> +
> +            data.write(suites)
> +
> +            data.write("static const size_t _clar_suite_count = %d;\n" % self.suite_count())
> +            data.write("static const size_t _clar_callback_count = %d;\n" % self.callback_count())
> +
> +        self.save_cache()
> +        return True
> +
> +if __name__ == '__main__':
> +    from optparse import OptionParser
> +
> +    parser = OptionParser()
> +    parser.add_option('-f', '--force', action="store_true", dest='force', default=False)
> +    parser.add_option('-x', '--exclude', dest='excluded', action='append', default=[])
> +    parser.add_option('-o', '--output', dest='output')
> +
> +    options, args = parser.parse_args()
> +    if len(args) > 1:
> +        print("More than one path given")
> +        sys.exit(1)
> +
> +    path = args.pop() if args else '.'
> +    output = options.output or path
> +    suite = TestSuite(path, output)
> +    suite.load(options.force)
> +    suite.disable(options.excluded)
> +    if suite.write():
> +        print("Written `clar.suite` (%d tests in %d suites)" % (suite.callback_count(), suite.suite_count()))
> diff --git a/t/unit-tests/clar/test/.gitignore b/t/unit-tests/clar/test/.gitignore
> new file mode 100644
> index 0000000000..a477d0c40c
> --- /dev/null
> +++ b/t/unit-tests/clar/test/.gitignore
> @@ -0,0 +1,4 @@
> +clar.suite
> +.clarcache
> +clar_test
> +*.o
> diff --git a/t/unit-tests/clar/test/Makefile b/t/unit-tests/clar/test/Makefile
> new file mode 100644
> index 0000000000..93c6b2ad32
> --- /dev/null
> +++ b/t/unit-tests/clar/test/Makefile
> @@ -0,0 +1,39 @@
> +#
> +# Copyright (c) Vicent Marti. All rights reserved.
> +#
> +# This file is part of clar, distributed under the ISC license.
> +# For full terms see the included COPYING file.
> +#
> +
> +#
> +# Set up the path to the clar sources and to the fixtures directory
> +#
> +# The fixture path needs to be an absolute path so it can be used
> +# even after we have chdir'ed into the test directory while testing.
> +#
> +CURRENT_MAKEFILE  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
> +TEST_DIRECTORY    := $(abspath $(dir $(CURRENT_MAKEFILE)))
> +CLAR_PATH         := $(dir $(TEST_DIRECTORY))
> +CLAR_FIXTURE_PATH := $(TEST_DIRECTORY)/resources/
> +
> +CFLAGS=-g -I.. -I. -Wall -DCLAR_FIXTURE_PATH=\"$(CLAR_FIXTURE_PATH)\"
> +
> +.PHONY: clean
> +
> +# list the objects that go into our test
> +objects = main.o sample.o
> +
> +# build the test executable itself
> +clar_test: $(objects) clar_test.h clar.suite $(CLAR_PATH)clar.c
> +	$(CC) $(CFLAGS) -o $@ "$(CLAR_PATH)clar.c" $(objects)
> +
> +# test object files depend on clar macros
> +$(objects) : $(CLAR_PATH)clar.h
> +
> +# build the clar.suite file of test metadata
> +clar.suite:
> +	python "$(CLAR_PATH)generate.py" .
> +
> +# remove all generated files
> +clean:
> +	$(RM) -rf *.o clar.suite .clarcache clar_test clar_test.dSYM
> diff --git a/t/unit-tests/clar/test/clar_test.h b/t/unit-tests/clar/test/clar_test.h
> new file mode 100644
> index 0000000000..0fcaa639aa
> --- /dev/null
> +++ b/t/unit-tests/clar/test/clar_test.h
> @@ -0,0 +1,16 @@
> +/*
> + * Copyright (c) Vicent Marti. All rights reserved.
> + *
> + * This file is part of clar, distributed under the ISC license.
> + * For full terms see the included COPYING file.
> + */
> +#ifndef __CLAR_TEST__
> +#define __CLAR_TEST__
> +
> +/* Import the standard clar helper functions */
> +#include "clar.h"
> +
> +/* Your custom shared includes / defines here */
> +extern int global_test_counter;
> +
> +#endif
> diff --git a/t/unit-tests/clar/test/main.c b/t/unit-tests/clar/test/main.c
> new file mode 100644
> index 0000000000..59e56ad255
> --- /dev/null
> +++ b/t/unit-tests/clar/test/main.c
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (c) Vicent Marti. All rights reserved.
> + *
> + * This file is part of clar, distributed under the ISC license.
> + * For full terms see the included COPYING file.
> + */
> +
> +#include "clar_test.h"
> +
> +/*
> + * Sample main() for clar tests.
> + *
> + * You should write your own main routine for clar tests that does specific
> + * setup and teardown as necessary for your application.  The only required
> + * line is the call to `clar_test(argc, argv)`, which will execute the test
> + * suite.  If you want to check the return value of the test application,
> + * your main() should return the same value returned by clar_test().
> + */
> +
> +int global_test_counter = 0;
> +
> +#ifdef _WIN32
> +int __cdecl main(int argc, char *argv[])
> +#else
> +int main(int argc, char *argv[])
> +#endif
> +{
> +	int ret;
> +
> +	/* Your custom initialization here */
> +	global_test_counter = 0;
> +
> +	/* Run the test suite */
> +	ret = clar_test(argc, argv);
> +
> +	/* Your custom cleanup here */
> +	cl_assert_equal_i(8, global_test_counter);
> +
> +	return ret;
> +}
> diff --git a/t/unit-tests/clar/test/main.c.sample b/t/unit-tests/clar/test/main.c.sample
> new file mode 100644
> index 0000000000..a4d91b72fa
> --- /dev/null
> +++ b/t/unit-tests/clar/test/main.c.sample
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (c) Vicent Marti. All rights reserved.
> + *
> + * This file is part of clar, distributed under the ISC license.
> + * For full terms see the included COPYING file.
> + */
> +
> +#include "clar_test.h"
> +
> +/*
> + * Minimal main() for clar tests.
> + *
> + * Modify this with any application specific setup or teardown that you need.
> + * The only required line is the call to `clar_test(argc, argv)`, which will
> + * execute the test suite.  If you want to check the return value of the test
> + * application, main() should return the same value returned by clar_test().
> + */
> +
> +#ifdef _WIN32
> +int __cdecl main(int argc, char *argv[])
> +#else
> +int main(int argc, char *argv[])
> +#endif
> +{
> +	/* Run the test suite */
> +	return clar_test(argc, argv);
> +}
> diff --git a/t/unit-tests/clar/test/resources/test/file b/t/unit-tests/clar/test/resources/test/file
> new file mode 100644
> index 0000000000..220f4aa98a
> --- /dev/null
> +++ b/t/unit-tests/clar/test/resources/test/file
> @@ -0,0 +1 @@
> +File
> diff --git a/t/unit-tests/clar/test/sample.c b/t/unit-tests/clar/test/sample.c
> new file mode 100644
> index 0000000000..faa1209262
> --- /dev/null
> +++ b/t/unit-tests/clar/test/sample.c
> @@ -0,0 +1,84 @@
> +#include "clar_test.h"
> +#include <sys/stat.h>
> +
> +static int file_size(const char *filename)
> +{
> +	struct stat st;
> +
> +	if (stat(filename, &st) == 0)
> +		return (int)st.st_size;
> +	return -1;
> +}
> +
> +void test_sample__initialize(void)
> +{
> +	global_test_counter++;
> +}
> +
> +void test_sample__cleanup(void)
> +{
> +	cl_fixture_cleanup("test");
> +
> +	cl_assert(file_size("test/file") == -1);
> +}
> +
> +void test_sample__1(void)
> +{
> +	cl_assert(1);
> +	cl_must_pass(0);  /* 0 == success */
> +	cl_must_fail(-1); /* <0 == failure */
> +	cl_must_pass(-1); /* demonstrate a failing call */
> +}
> +
> +void test_sample__2(void)
> +{
> +	cl_fixture_sandbox("test");
> +
> +	cl_assert(file_size("test/nonexistent") == -1);
> +	cl_assert(file_size("test/file") > 0);
> +	cl_assert(100 == 101);
> +}
> +
> +void test_sample__strings(void)
> +{
> +	const char *actual = "expected";
> +	cl_assert_equal_s("expected", actual);
> +	cl_assert_equal_s_("expected", actual, "second try with annotation");
> +	cl_assert_equal_s_("mismatched", actual, "this one fails");
> +}
> +
> +void test_sample__strings_with_length(void)
> +{
> +	const char *actual = "expected";
> +	cl_assert_equal_strn("expected_", actual, 8);
> +	cl_assert_equal_strn("exactly", actual, 2);
> +	cl_assert_equal_strn_("expected_", actual, 8, "with annotation");
> +	cl_assert_equal_strn_("exactly", actual, 3, "this one fails");
> +}
> +
> +void test_sample__int(void)
> +{
> +	int value = 100;
> +	cl_assert_equal_i(100, value);
> +	cl_assert_equal_i_(101, value, "extra note on failing test");
> +}
> +
> +void test_sample__int_fmt(void)
> +{
> +	int value = 100;
> +	cl_assert_equal_i_fmt(022, value, "%04o");
> +}
> +
> +void test_sample__bool(void)
> +{
> +	int value = 100;
> +	cl_assert_equal_b(1, value);       /* test equality as booleans */
> +	cl_assert_equal_b(0, value);
> +}
> +
> +void test_sample__ptr(void)
> +{
> +	const char *actual = "expected";
> +	cl_assert_equal_p(actual, actual); /* pointers to same object */
> +	cl_assert_equal_p(&actual, actual);
> +}
